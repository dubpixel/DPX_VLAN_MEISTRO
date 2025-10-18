# Changelog

## v1.87

### Added or Changed
- Fixed IP prompt default values not displaying by changing `$ipDefaults[$promptName]` to `$ipDefaults.$promptName` to properly access PSCustomObject properties from JSON data
- Updated version to 1.87 and ASCII art title accordingly

## v1.86

### Added or Changed
- Implemented comprehensive subnet-aware IP validation that checks complete IP addresses against subnet constraints instead of dumb 0-255 octet validation
- Added configuration summary at script end showing selected NIC, subnet, and all VLAN IPs with broadcast addresses
- Updated IP input prompts to display subnet information for better user guidance
- Added Test-IPAgainstSubnet function for proper IP/subnet validation with network/broadcast calculation
- Updated version to 1.86 and ASCII art title accordingly

## v1.85

## v1.83

### Added or Changed
- Refactored hardcoded VLAN configurations to be defined as variables ($hardcoded4Wall, $hardcodedAeonPoint, $hardcodedDesert) at the top of the script for better maintainability
- Simplified the else block in VLAN set building to assign these pre-defined variables instead of inline definitions
- Updated version to 1.83 and ASCII art title accordingly

## v0.0.0

### Added or Changed
- 

### Removed

- S