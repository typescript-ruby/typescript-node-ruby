require "tmpdir"
require "tempfile"
require "typescript-src"
require "typescript-node/version"
require "typescript-node/compile_result"
require "open3"

module TypeScript
  module Node
    class << self

      def tsc_version
        TypeScript::Src.version
      end

      def tsc(*args)
        cmd = [node, Src.tsc_path.to_s, *args]
        Open3.capture3(*cmd)
      end

      # Compile TypeScript source file.
      # @param [String] source_file TypeScript source file
      # @return [TypeScript::Node::CompileResult] compile result
      def compile_file(source_file, *tsc_options)
        Dir.mktmpdir do |output_dir|
          output_file = File.join(output_dir, "out.js")
          stdout, stderr, exit_status = tsc(*tsc_options, '--out', output_file, source_file)

          output_js = File.exists?(output_file) ? File.read(output_file) : nil
          CompileResult.new(
            output_js,
            exit_status,
            stdout,
            stderr,
          )
        end
      end

      # Compile TypeScript to JavaScript.
      # @param [String] source TypeScript to be compiled
      # @return [String] Resulted JavaScript
      def compile(source, *tsc_options)
        js_file = Tempfile.new(["typescript-node", ".ts"])
        begin
          js_file.write(source)
          js_file.close
          result = compile_file(js_file.path, *tsc_options)
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
        unless locate_executable(node)
          raise "typescript-node requires node command, but it's not found. Please install it. " +
              "Set TS_NODE environmental variable If you want to use node command in non-standard path."
        end
      end
    end
  end
end

TypeScript::Node.check_node
