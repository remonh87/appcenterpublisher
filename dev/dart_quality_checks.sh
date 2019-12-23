#!/bin/bash -ex

dartanalyzer --fatal-hints .
pub run test
pub run dependency_validator --ignore=json_serializable,functional_data_generator,sum_types_generator,test_coverage
dev/format_dart_code.sh --set-exit-if-changed
dev/generate_code.sh
pub publish --dry-run