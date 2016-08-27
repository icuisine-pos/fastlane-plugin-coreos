describe Fastlane::Actions::CoreosAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The coreos plugin is working!")

      Fastlane::Actions::CoreosAction.run(nil)
    end
  end
end
