# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Atlas::Peering do
  it 'has a version number' do
    expect(Atlas::Peering::VERSION).not_to be nil
  end
end
