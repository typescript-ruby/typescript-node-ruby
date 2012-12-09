require "tmpdir"
require "tempfile"
require "typescript-src"
require "typescript-node/version"
require "typescript-node/compile_result"

module TypeScript
  module Node

    class << self

      # Compile TypeScript source file.
      # @param [String] source_file TypeScript source file
      # @return [TypeScript::Node::CompileResult] compile result
      def compile_file(source_file)
        Dir.mktmpdir do |output_dir|
          output_file = File.join(output_dir, "out.js")
          cmd = [node, Src.tsc_path, "--out", output_file, source_file]
          Open3.popen3(*cmd) do |stdin, stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            output_js = File.exists?(output_file) ? File.read(output_file) : nil
            CompileResult.new(
                output_js,
                exit_status,
                stdout.read,
                stderr.read
            )
          end
        end
      end

      # Compile TypeScript to JavaScript.
      # @param [String] source TypeScript to be compiled
      # @return [String] Resulted JavaScript
      def compile(source)
        js_file = Tempfile.new(["typescript-node", ".ts"])
        begin
          js_file.write(source)
          js_file.close
          result = compile_file(js_file.path)
          if result.success?
            result.js
          else
            raise result.stderr
          end
        ensure
          js_file.unlink
        end
      end

      # node command
      # TS_NODE environmental variable is used when it is set.
      def node
        ENV["TS_NODE"] || "node"
      end

      def locate_executable(cmd)
        if RbConfig::CONFIG["host_os"] =~ /mswin|mingw/ && File.extname(cmd) == ""
          cmd << ".exe"
        end

        if File.executable? cmd
          cmd
        else
          path = ENV['PATH'].split(File::PATH_SEPARATOR).find { |p|
            full_path = File.join(p, cmd)
            File.executable?(full_path) && File.file?(full_path)
          }
          path && File.expand_path(cmd, path)
        end
      end

      def check_node
        unless locate_executable(self.node)
          raise "typescript-node requires node command, but it's not found. Please install it. " +
                    "Set TS_NODE environmental variable If you want to use node command in non-standard path."
        end
      end
    end
  end
end

TypeScript::Node.check_node
