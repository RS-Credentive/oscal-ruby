module Oscal
  # Container Class for an Oscal Document - the root of any oscal file
  class Document < OscalObject
    OPTIONAL = {
      assessment_result: AssessmentResult,
    }.freeze
  end
end
