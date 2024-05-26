# typed: true

require_relative "../arrays"
require_relative "assemblies"

module Oscal
  module AssessmentResultModule
    # These Arrays are specific to the Assessment Result
    class ActivityArray < Oscal::OscalArray
      MEMBER_TYPE = Activity
    end

    class AssessmentPlatformArray < Oscal::OscalArray
      MEMBER_TYPE = AssessmentPlatform
    end

    class AssessmentTaskArray < Oscal::OscalArray
      MEMBER_TYPE = AssessmentTask
    end

    class AssociatedActivityArray < Oscal::OscalArray
      MEMBER_TYPE = AssociatedActivity
    end

    class AttestationArray < Oscal::OscalArray
      MEMBER_TYPE = Attestation
    end

    class ComponentArray < Oscal::OscalArray
      MEMBER_TYPE = Component
    end

    class ControlObjectiveSelectionArray < Oscal::OscalArray
      MEMBER_TYPE = ControlObjectiveSelection
    end

    class ControlSelectionArray < Oscal::OscalArray
      MEMBER_TYPE = ControlSelection
    end

    class EntryArray < Oscal::OscalArray
      MEMBER_TYPE = Entry
    end

    class ExcludeControlArray < Oscal::OscalArray
      MEMBER_TYPE = ExcludeControl
    end

    class ExcludeObjectiveArray < Oscal::OscalArray
      MEMBER_TYPE = ExcludeObjective
    end

    class FindingArray < Oscal::OscalArray
      MEMBER_TYPE = Finding
    end

    class IncludeControlArray < Oscal::OscalArray
      MEMBER_TYPE = IncludeControl
    end

    class InventoryItemArray < Oscal::OscalArray
      MEMBER_TYPE = InventoryItem
    end

    class LinkArray < Oscal::OscalArray
      MEMBER_TYPE = Oscal::Link
    end

    class MethodArray < StringDataTypeArray
    end

    class ObjectivesAndMethodsArray < Oscal::OscalArray
      MEMBER_TYPE = ObjectivesAndMethods
    end

    class ObservationArray < Oscal::OscalArray
      MEMBER_TYPE = Observation
    end

    class PartArray
      MEMBER_TYPE = Link
    end

    class PartyUuidArray < Oscal::UuidArray
    end

    class PropArray < Oscal::OscalArray
      MEMBER_TYPE = Property
    end

    class ResponsibleRoleArray < Oscal::OscalArray
      MEMBER_TYPE = ResponsibleRole
    end

    class ResultArray < Oscal::OscalArray
      MEMBER_TYPE = Result
    end

    class RiskArray < Oscal::OscalArray
      MEMBER_TYPE = Risk
    end

    class StatementIdArray < Oscal::TokenDataTypeArray
    end

    class StepArray < Oscal::OscalArray
      MEMBER_TYPE = Step
    end

    class SubjectArray < Oscal::OscalArray
      MEMBER_TYPE = Subject
    end

    class TypeArray < Oscal::TokenDataTypeArray
    end

    class UserArray < Oscal::OscalArray
      MEMBER_TYPE = User
    end
  end
end
