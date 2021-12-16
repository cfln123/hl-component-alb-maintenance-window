require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/path.test.yaml")).to be_truthy
    end
  end

  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/path/alb-maintenance-window.compiled.yaml") }

  context 'Resource MaintenanceWindowRule' do

    let(:properties) { template["Resources"].values[0]["Properties"] }

    it 'Expected path' do
      expect(properties["Conditions"][0]["Field"]).to eq('path-pattern')
      expect(properties["Conditions"][0]["Values"][0]).to eq('/test')
    end

  end

end