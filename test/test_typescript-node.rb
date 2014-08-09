require 'test/unit'
require 'typescript-node'


class TestTypeScriptNode < Test::Unit::TestCase
  # @return [TypeScript::Node::CompileResult]
  def compile_success
    file = File.expand_path('data/hello.ts', File.dirname(__FILE__))
    TypeScript::Node.compile_file(file)
  end

  def compile_failure
    file = File.expand_path('data/bad.ts', File.dirname(__FILE__))
    TypeScript::Node.compile_file(file)
  end

  def test_compile_success
    subject = compile_success

    assert { subject.exit_status == 0 }
    assert { subject.success? }
    assert { subject.js == %Q{console.log("Hello TypeScript");\n} }
    assert { subject.stdout == '' }
    assert { subject.stderr == '' }
  end

  def test_compile_failure
    subject = compile_failure

    assert { subject.exit_status != 0 }
    assert { !subject.success? }
    assert { subject.stdout == '' }
    assert { subject.stderr != '' }
  end

end
