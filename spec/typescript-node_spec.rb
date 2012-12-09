require "typescript-node"

module TypeScript
  module Node
    describe "#compile_file" do
      subject do
        hello_ts = File.expand_path("data/hello.ts", File.dirname(__FILE__))
        Node.compile_file(hello_ts)
      end

      its(:exit_status) { should == 0 }
      it { should be_success }
      its(:js) { should == "console.log(\"Hello TypeScript\");\r\n" }
      its(:stdout) { should == "" }
      its(:stderr) { should == "" }
    end
  end
end
