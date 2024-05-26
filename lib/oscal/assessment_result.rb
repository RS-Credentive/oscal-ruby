# typed: true

require_relative "datatypes"
require_relative "assembly"
require_relative "back_matter"
require_relative "metadata_block"
require_relative "assessment_result/assemblies"
require_relative "assessment_result/arrays"

module Oscal
  class AssessmentResult < Assembly
    MANDATORY = {
      uuid: UuidDataType,
      metadata: MetadataBlock,
      import_ap: AssessmentResultModule::ImportAP,
      results: AssessmentResultModule::ResultArray,
    }.freeze
    OPTIONAL = {
      local_definitions: AssessmentResultModule::LocalDefinitions,
      back_matter: BackMatter,
    }.freeze
  end
end
