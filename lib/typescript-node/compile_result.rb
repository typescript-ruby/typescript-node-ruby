# coding: utf-8

module TypeScript
  module Node
    class CompileResult

      # Constructor
      #
      # @param [String] js compiled JavaScript
      # @param [Fixnum] exit_status return code of tsc command
      # @param [String] stdout Standard out
      # @return [String] stderr Standard err
      def initialize(js, exit_status, stdout, stderr)
        @js = js
        @exit_status = exit_status
        @stdout = stdout
        @stderr = stderr
      end

      attr_reader :js, :source_map, :exit_status, :stdout, :stderr

      def success?
        @exit_status == 0
      end

    end
  end
end

