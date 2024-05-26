require_relative "lib/oscal"
require "json"
# ar_hash = JSON.load_file("spec/oscal-content/examples/ar/json/ifa_assessment-results-example.json")["assessment-results"]
# Oscal::AssessmentResult::AssessmentResult.new(ar_hash)

IMPORT_AP_HASH = {
  href: "https://github.com/usnistgov/oscal-content/blob/main/examples/ap/json/ifa_assessment-plan-example.json",
  remarks: "This is a legit remark",
}

Oscal::AssessmentResultModule::ImportAP.new IMPORT_AP_HASH
