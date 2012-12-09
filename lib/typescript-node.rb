require "tmpdir"
require "tempfile"
require "typescript-src"
require "typescript-node/version"
require "typescript-node/compile_result"

module TypeScript
  module Node

    class << self
      def compile_file(source_file)
        Dir.mktmpdir do |output_dir|
          output_file = File.join(output_dir, "out.js")
          cmd = ["node", Src.tsc_path, "--out", output_file, source_file]
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
    end
  end
end
