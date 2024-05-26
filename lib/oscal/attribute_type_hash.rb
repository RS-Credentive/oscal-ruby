require_relative("datatypes")
require_relative("arrays")

module Oscal
  module AssessmentResultModule
    ATTRIBUTE_TYPE_HASH = {
      activities: ActivityArray,
      activity_uuid: UuidDataType,
      assessment_platforms: AssessmentPlatformArray,
      assessment_log: AssessmentLog,
      associated_activities: AssociatedActivityArray,
      attestations: AttestationArray,
      components: ComponentArray,
      control_id: TokenDataType,
      control_objective_selections: ControlObjectiveSelectionArray,
      control_selections: ControlSelectionArray,
      description: MarkupMultilineDataType,
      end: DateTimeWithTimezoneDataType,
      entries: EntryArray,
      exclude_controls: ExcludeControlArray,
      exclude_objectives: ExcludeObjectiveArray,
      href: UriReferenceDataType,
      import_ap: ImportAP,
      include_all: IncludeAll,
      include_controls: IncludeControlArray,
      inventory_items: InventoryItemArray,
      links: LinkArray,
      local_definitions: LocalDefinitions,
      metadata: MetadataBlock,
      methods: MethodArray,
      objective_id: TokenDataType,
      objectives_and_methods: ObjectivesAndMethodsArray,
      observations: ObservationArray,
      parts: PartArray,
      party_uuids: PartyUuidArray,
      props: PropArray,
      related_controls: RelatedControls,
      remarks: MarkupMultilineDataType,
      responsible_roles: ResponsibleRoleArray,
      results: ResultArray,
      reviewed_controls: ReviewedControls,
      risks: RiskArray,
      role_id: TokenDataType,
      start: DateTimeWithTimezoneDataType,
      statement_ids: StatementIdArray,
      steps: StepArray,
      subjects: SubjectArray,
      subject_uuid: UuidDataType,
      tasks: AssessmentTaskArray,
      title: MarkupMultilineDataType,
      type: TokenDataType,
      types: TypeArray,
      uuid: UuidDataType,
      users: UserArray,
    }.freeze
  end

  def self.get_type_of_attribute(attribute_name)
    klass = Oscal::AssessmentResultModule::ATTRIBUTE_TYPE_HASH[attribute_name.to_sym]
    if klass == nil
      raise InvalidTypeError, "No type found for #{attribute_name}"
    else
      klass
    end
  end
end
