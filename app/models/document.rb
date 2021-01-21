# frozen_string_literal: true

# app/models/document.rb
class Document < ApplicationRecord
  validates :signature, presence: true
end