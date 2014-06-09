require "spec_helper"

def add_state(name, states = [], default = nil)
  Dummy.add_state(name, :states => states, :default => default)
end

describe ModelState do
  let(:record) {Dummy.create}
  let(:name)   {:state1}

  describe "::add_state" do
    context "when params invalid" do
      it {
        expect{
          add_state(name, [])
        }.to raise_error(ModelState::InvalidState)
      }

      it {
        expect{
          add_state(name, "s1,s2")
        }.to raise_error(ModelState::InvalidState)
      }

      it {
        expect{
          add_state(name, [:s1], [:s1])
        }.to raise_error(ModelState::InvalidState)
      }

      it {
        expect{
          add_state(name, [:s1], "s1")
        }.to raise_error(ModelState::InvalidState)
      }

      it {
        expect{
          add_state(name, [:s1], :s2)
        }.to raise_error(ModelState::InvalidState)
      }
    end

    context "when params valid" do
      it {expect(Dummy.state_fields.count).to eq 1}

      it {expect(record.state).to eq :S1}
      it {expect{record.state = :S4}.to change{record.valid?}.to(false)}
    end
  end

  describe "#set_states" do
    let(:op) {record.set_states(:state => :s2)}

    it {expect{op}.to change{record.state}.to(:S2)}
  end

  describe "#set_states" do
    let(:op) {record.get_states(:state)}

    it {expect(op).to eq({:state => :S1})}
  end

  describe "#on_states?" do
    let(:op1) {record.on_states?(:state => :S1)}
    let(:op2) {record.on_states?(:state => :S2)}

    it {expect(op1).to be true}
    it {expect(op2).to be false}
  end

  describe "#set_state" do
    let(:op) {record.set_state(:state, :s2)}

    it {expect{op}.to change{record.state}.to(:S2)}
  end

  describe "#set_state" do
    let(:op) {record.get_state(:state)}

    it {expect(op).to be :S1}
  end

  describe "#on_state?" do
    let(:op1) {record.on_state?(:state, :S1)}
    let(:op2) {record.on_state?(:state, :S2)}

    it {expect(op1).to be true}
    it {expect(op2).to be false}
  end

end
