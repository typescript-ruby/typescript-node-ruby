require 'test/unit'
require 'typescript-node'


class TestTypeScriptNode < Test::Unit::TestCase
  def test_check_node
    TypeScript::Node.check_node
  end

  def test_version
    assert { TypeScript::Node.tsc_version >= '1.0.1' }
  end

  def test_compile_file_in_success
    file = File.expand_path('data/hello.ts', File.dirname(__FILE__))
    subject = TypeScript::Node.compile_file(file)

    assert { subject.exit_status == 0 }
    assert { subject.success? }
    assert { subject.js == %Q{console.log("Hello TypeScript");\n} }
    assert { subject.stdout == '' }
    assert { subject.stderr == '' }
  end

  def test_compile_file_in_failure
    file = File.expand_path('data/bad.ts', File.dirname(__FILE__))
    subject = TypeScript::Node.compile_file(file)

    assert { subject.exit_status != 0 }
    assert { !subject.success? }
    assert { subject.stdout == '' }
    assert { subject.stderr != '' }
  end

  def test_compile
    subject = TypeScript::Node.compile('class T { say() { console.log("Hello, world!") } }')

    assert { subject != '' }
    assert { subject != nil }
  end
end
