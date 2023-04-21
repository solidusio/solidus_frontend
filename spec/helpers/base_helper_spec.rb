# frozen_string_literal: true

require 'spec_helper'

module Spree
  describe BaseHelper, type: :helper do
    # Regression test for https://github.com/spree/spree/issues/2759
    it "nested_taxons_path works with a Taxon object" do
      taxonomy = create(:taxonomy, name: "smartphones")
      taxon = create(:taxon, name: "iphone", taxonomy: taxonomy)
      expect(spree.nested_taxons_path(taxon)).to eq("/t/smartphones/iphone")
    end
  end
end
