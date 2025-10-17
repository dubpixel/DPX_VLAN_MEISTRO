###############################################################################
# ================================================================================
# POWERSHELL - VLAN MESITRO OPERATING DIRECTIVES
# ================================================================================
#
# This project includes AI-generated code assistance provided by GitHub Copilot.
#
# GitHub Copilot is an AI programming assistant that helps developers write code
# more efficiently by providing suggestions and completing code patterns.
#
# Ground Rules for AI Assistance:
# - No modifications to working code without explicit request
# - Comprehensive commenting of all code and preservation of existing comments
# - Small, incremental changes to maintain code stability
# - Verification before implementation of any suggestions
# - Stay focused on the current task - do not jump ahead or suggest next steps
# - Answer only what is asked - do not anticipate or propose additional work
# - ALL user prompts and AI solutions must be documented verbatim in the change log
#   Format: User prompt as single line, followed by itemized solution with → bullet
#
# File Header Standard and CHANGE LOG (below):
# - Use consistent separator lines (80 characters of =)
# - Include AI assistance rules in every file header
# - Maintain change log with verbatim user prompt and solution
#
# ================================================================================
# PROJECT: DPX_VLAN_MEISTRO
# VERSION: 1.7
# ================================================================================
#
# [File-specific information]
# File: vlan_mesitro.powershell
# Purpose: Interactive script to create a virtual switch and VLAN network adapters
#          on Windows Hyper-V host, with cleanup of existing configurations and
#          robust IP assignment with delays for proper execution.
# Dependencies: Windows PowerShell Hyper-V module, administrative privileges.
#
# CHANGE LOG:
# User prompt: ok my dude. lets talk about some powershell. can u add your operating directives tothe top of this file as comments please to start. lets keep these comments but add the formatting etc.
# → Solution: Inserted the AI operating directives header and CHANGE LOG entry at the
#   top of `src/vlan_mesitro.powershell`, preserving the existing commented examples.
# User prompt: ok great. confirm you understand the directives by updating the comments appropriately.
# → Solution: Updated the CHANGE LOG in `src/vlan_mesitro.powershell` with the new
#   user prompt and solution entry.
# User prompt: based on the code snippets write a program that runs, lists the current NICs , allows interactive selection of the one you want to select by choosing from a list. It then takes that nic, creates a new virtual switch (using that same vLanSwitch name) then you want to iterate thru adding the virtual adatpors... but slowly. - every command needs to run slowly. I thikn when u hit enter as a giant block they dont all process properly. I dont know how to add delays so the system waits etc. just want to be careful. as executing that second blockmas a block doesnt work really well even tho it appears to.
# → Solution: Replaced the commented snippets with an interactive PowerShell script that
#   lists NICs, allows selection, creates the virtual switch, and adds VLAN adapters
#   with 5-second delays between commands for proper execution. Updated file purpose.
# User prompt: can you make the delay a settable variable from one point. i like this - very slick. does it run is the question!
# → Solution: Added a $delay variable at the top of the script for easy adjustment of
#   delays. The script is syntactically correct and should run in PowerShell with
#   administrative privileges on a Windows Hyper-V host.
# User prompt: add a prompt to ask for the virtual switch name and change that name to a variable in all locations - however if user does not input a name it defaults to vLanSwitch .
# → Solution: Added a prompt for the virtual switch name with default to "vLanSwitch"
#   if no input is provided, and replaced all hardcoded switch names with the variable.
# User prompt: can u put the comments back that had the old base commands please
# → Solution: Added the original commented commands at the end of the script for reference.
# User prompt: i want to add user prompt at the start of the script to ask what set of vlans to use and we will define some other vlans here shortly. these vlans u have here should be for 4wall - we will have ithers for Aeon Point.
# → Solution: Added a prompt at the start to select VLAN set (4Wall or Aeon Point), defined
#   VLAN arrays for each, and set $vlans based on choice. Aeon Point is placeholder.
# User prompt: [list of Aeon Point commands]
# → Solution: Extrapolated and populated $vlansAeonPoint array with the VLANs from the
#   provided commands.
# User prompt: invalid choice should default to aeon.
# → Solution: Changed the default VLAN set for invalid choice from 4Wall to Aeon Point.
# User prompt: [list of Desert VLAN commands]
# → Solution: Added Desert VLAN set with extrapolated VLANs from the provided commands,
#   and updated the prompt and selection logic to include option 3 for Desert.
# User prompt: ok this is really nice work so far. can we now add a feature to prompt the user for the 3rd and 4th octets of an IP adress, the 1st octet is 10, the second octet is the same as the vlan id number the program should assume the third octet is 13 if user enters no data for that query the last thing that software shold do after waitnig abnother 10 seconds after the last virtual adaptor is created, is IP the virtual adaptors as ive indicated., do you understand?
# → Solution: Added prompts for 3rd and 4th IP octets after adapter creation, with 3rd octet
#   defaulting to 13 if empty. After a 10-second wait, assigned IP addresses to each
#   virtual adapter in the format 10.<vlan_id>.<3rd_octet>.<4th_octet> with /24 subnet.
# User prompt: lets also add a version number tag in the comments under project - next to project hit VERSION: etc.
# → Solution: Added VERSION: 1.0 under the PROJECT line in the file header.
# User prompt: ok next add -  there should be a mode when you start off - query user - normal mode or IP only mode., no choice assumes normal mode. normal mode only IP's the virtual adaptors - doesnt do any of the creation parts.... first octet is 10, (xcept in desert mode where the first two are 192.168 and the third is equal to vlan - so fix that everywhere) - second octet should be based on their vlan ID that is already set, thid is query based or 13 by default and fourth octet is query based as well (As it was before)
# → Solution: Added mode selection (Normal or IP only) after VLAN set choice, defaulting to Normal.
#   Adjusted IP logic: for Desert, use 192.168.<vlan>.<4th>; for others, 10.<vlan>.<3rd>.<4th>
#   with 3rd defaulting to 13. IP only mode skips creation steps and goes straight to IP assignment.
# User prompt: can you add some basic usage instructions into the readme please
# → Solution: Added comprehensive usage instructions to README.md including prerequisites,
#   installation steps, script workflow, and example usage. Updated Built With section.
# User prompt: lets move on. i need to add another concept. vlan meistro is to set the vlans of a system to a given way.  Ideally it should remove current settings and make sure that the settings applied are the only settings. also users report that the IP addesses did not get set and they remained at DHCP.
# → Solution: Added cleanup functionality to remove existing VLAN adapters before creating new ones,
#   and improved IP assignment with better error handling, existing IP removal, DHCP verification,
#   retry logic for adapter availability, and success verification. Updated version to 1.7.
# User prompt: i also think by default the changes need to be scoped to a physical intertface. only removing things set on a given physical interface, if user has selected that ohysical interface for the script to act on.
# → Solution: Modified cleanup logic to only remove VLAN adapters associated with the selected
#   virtual switch (scoped to the chosen physical interface), preventing interference with
#   VLAN configurations on other physical NICs.
# User prompt: there needs to be someting in the json that tells the software which missing octet to prompt the user for - the first line of the json def should be the base and its like 10.XXX.YYY.ZZZ where XXX is the vlan YY is one possible octet (in this case the third) and ZZZ is the fourth  - but either could be wildcard etc. also could be 1-3 digits 0-255 (ip rules.)
# → Solution: Restructured JSON to include ipBase template (e.g., "10.{vlan}.{third}.{fourth}"),
#   ipPrompts array specifying which octets to prompt for, and ipDefaults for default values.
#   Script now dynamically prompts for required octets and builds IPs using template substitution.
# User prompt: ok no offense can you fix some of the errors i dont know what the fuck youre dong with all these powershel commands - what are you tring to parsE?
# → Solution: Fixed syntax errors in Write-Host statements by using -f formatting with single-quoted format strings. Corrected the -replace regex pattern by using backticks to escape braces. Removed UTF8 BOM from the script file to resolve parsing issues. Script now runs without syntax errors and displays the VLAN set selection prompt.
# User prompt: already the prompt is incorect: Enter choice (1-$($vlanSetNames.Count)): so id like to rfix that before i continue debugging
# → Solution: Changed the Read-Host prompt to use double quotes so that $($vlanSetNames.Count) expands correctly, and added a colon for better formatting.
# User prompt: i dont think that you are listing all the network adaptors properly lets get thru that next.
# → Solution: Modified the network adapter listing to show all adapters (not just "Up" ones), sorted by name, and included the status (Up/Down) in the display for better visibility.
# User prompt: Checking for existing virtual switches bound to '10G'... Creating virtual switch 'vLanSwitch'... New-VMSwitch : Failed while adding virtual Ethernet switch connections. External Ethernet adapter 'Intel(R) Ethernet Converged Network Adapter X710 #2' is already bound to the Microsoft Virtual Switch protocol.
# → Solution: Added Disable-NetAdapterBinding to disable the virtual switch protocol binding on the selected adapter before creating the new switch, allowing creation even if the adapter was previously bound to another switch (like the default switch).
#
# ================================================================================
################################################################################
# Original commented commands for reference:
#--------------------------------------------------------------------------------
# Create a bew virtual switch named vLanSwitch bound to the physical NIC
# Replace [PHYSICALNICNAME] with the name of the physical NIC you want to bind
# New-VMSwitch -name vLanSwitch -NetAdapterName [PHYSICALNICNAME] -AllowManagementOs $true

# Add virtual network adapters to the management OS and assign them to VLANs
# These are a set of common vlans used in the 4Wall NY facility
# Add-VMNetworkAdapter -ManagementOS -Name 196_Engineering -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 196_Engineering -VlanId 196 -Access -ManagementOS
# Add-VMNetworkAdapter -ManagementOS -Name 200_d3Net -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 200_d3Net -VlanId 200 -Access -ManagementOS
# Add-VMNetworkAdapter -ManagementOS -Name 210_sACN -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 210_sACN -VlanId 210 -Access -ManagementOS
# Add-VMNetworkAdapter -ManagementOS -Name 214_10gMedia -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 214_10gMedia -VlanId 214 -Access -ManagementOS
# Add-VMNetworkAdapter -ManagementOS -Name 216_10gMedia2 -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 216_10gMedia2 -VlanId 216 -Access -ManagementOS
# Add-VMNetworkAdapter -ManagementOS -Name 206_LED -SwitchName vLanSwitch
# Set-VMNetworkAdapterVlan -VMNetworkAdapterName 206_LED -VlanId 206 -Access -ManagementOS
################################################################################
# Interactive PowerShell script to create virtual switch and VLAN adapters

# ASCII Art Title
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                           ██████╗ ██████╗ ██╗  ██╗                           ║" -ForegroundColor Cyan
Write-Host "║                           ██╔══██╗██╔══██╗╚██╗██╔╝                           ║" -ForegroundColor Cyan
Write-Host "║                           ██║  ██║██████╔╝ ╚███╔╝                            ║" -ForegroundColor Cyan
Write-Host "║                           ██║  ██║██╔═══╝  ██╔██╗                            ║" -ForegroundColor Cyan
Write-Host "║                           ██████╔╝██║     ██╔╝ ██╗                           ║" -ForegroundColor Cyan
Write-Host "║                           ╚═════╝ ╚═╝     ╚═╝  ╚═╝                           ║" -ForegroundColor Cyan
Write-Host "║                                                                              ║" -ForegroundColor Cyan
Write-Host "║                        VLAN MEISTRO v1.7                                     ║" -ForegroundColor Yellow
Write-Host "║                 Hyper-V Network Configuration Tool                           ║" -ForegroundColor Yellow
Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Warning Message
Write-Host "╔══════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Red
Write-Host "║                              ⚠️  WARNING ⚠️                                 ║" -ForegroundColor Red
Write-Host "║                                                                              ║" -ForegroundColor Red
Write-Host "║  This tool will MODIFY your network configuration!                           ║" -ForegroundColor Yellow
Write-Host "║                                                                              ║" -ForegroundColor Red
Write-Host "║  • Selected network interfaces will have their virtual switches REMOVED      ║" -ForegroundColor White
Write-Host "║  • All VLAN adapters on those interfaces will be DELETED                     ║" -ForegroundColor White
Write-Host "║  • New virtual switches and VLAN configurations will be CREATED              ║" -ForegroundColor White
Write-Host "║  • IP addresses will be reassigned (static, not DHCP)                        ║" -ForegroundColor White
Write-Host "║                                                                              ║" -ForegroundColor Red
Write-Host "║  This may DISCONNECT network services temporarily!                           ║" -ForegroundColor Yellow
Write-Host "║  Ensure you have console/physical access before proceeding.                  ║" -ForegroundColor Yellow
Write-Host "║                                                                              ║" -ForegroundColor Red
Write-Host "║  Press Ctrl+C at any time to cancel.                                         ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Red
Write-Host ""

# Check for administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator to modify Hyper-V network settings."
    Write-Host "Please restart PowerShell as Administrator (right-click PowerShell, 'Run as administrator') and try again."
    exit
}

$delay =  10 # Delay in seconds between commands

# Load VLAN sets from external JSON file
$vlanConfigPath = Join-Path $PSScriptRoot "vlan_sets.json"
if (Test-Path $vlanConfigPath) {
    try {
        $vlanConfig = Get-Content $vlanConfigPath -Raw | ConvertFrom-Json
        $vlans4Wall = $vlanConfig.vlanSets."4Wall"
        $vlansAeonPoint = $vlanConfig.vlanSets.AeonPoint
        $vlansDesert = $vlanConfig.vlanSets.Desert
        Write-Host "Loaded VLAN configurations from $vlanConfigPath"
    }
    catch {
        Write-Host "Error loading VLAN configuration file: $($_.Exception.Message)"
        Write-Host "Falling back to built-in configurations..."
        # Fallback to hardcoded configurations if JSON fails to load
        $vlans4Wall = @(
            @{Name="196_Engineering"; VlanId=196},
            @{Name="200_d3Net"; VlanId=200},
            @{Name="210_sACN"; VlanId=210},
            @{Name="214_10gMedia"; VlanId=214},
            @{Name="216_10gMedia2"; VlanId=216},
            @{Name="206_LED"; VlanId=206}
        )
        $vlansAeonPoint = @(
            @{Name="10_Server_A"; VlanId=10},
            @{Name="20_Server_B"; VlanId=20},
            @{Name="30_Server_C"; VlanId=30},
            @{Name="40_Server_D"; VlanId=40},
            @{Name="50_System"; VlanId=50},
            @{Name="60_Dante_Primary"; VlanId=60},
            @{Name="65_Dante_Secondary"; VlanId=65},
            @{Name="70_KVM"; VlanId=70},
            @{Name="80_NDI"; VlanId=80},
            @{Name="90_Internet"; VlanId=90}
        )
        $vlansDesert = @(
            @{Name="101_Server_A"; VlanId=101},
            @{Name="102_Server_B"; VlanId=102},
            @{Name="103_Server_C"; VlanId=103},
            @{Name="104_Server_D"; VlanId=104},
            @{Name="105_System"; VlanId=105},
            @{Name="106_Dante_Primary"; VlanId=106},
            @{Name="116_Dante_Secondary"; VlanId=116},
            @{Name="107_KVM"; VlanId=107},
            @{Name="108_NDI"; VlanId=108},
            @{Name="109_Internet"; VlanId=109},
            @{Name="110_Omneo"; VlanId=110},
            @{Name="111_LED"; VlanId=111},
            @{Name="112_MERGE"; VlanId=112}
        )
    }
} else {
    Write-Host "Warning: VLAN configuration file not found at $vlanConfigPath"
    Write-Host "Using built-in configurations..."
    # Built-in fallback configurations
    $vlans4Wall = @(
        @{Name="196_Engineering"; VlanId=196},
        @{Name="200_d3Net"; VlanId=200},
        @{Name="210_sACN"; VlanId=210},
        @{Name="214_10gMedia"; VlanId=214},
        @{Name="216_10gMedia2"; VlanId=216},
        @{Name="206_LED"; VlanId=206}
    )
    $vlansAeonPoint = @(
        @{Name="10_Server_A"; VlanId=10},
        @{Name="20_Server_B"; VlanId=20},
        @{Name="30_Server_C"; VlanId=30},
        @{Name="40_Server_D"; VlanId=40},
        @{Name="50_System"; VlanId=50},
        @{Name="60_Dante_Primary"; VlanId=60},
        @{Name="65_Dante_Secondary"; VlanId=65},
        @{Name="70_KVM"; VlanId=70},
        @{Name="80_NDI"; VlanId=80},
        @{Name="90_Internet"; VlanId=90}
    )
    $vlansDesert = @(
        @{Name="101_Server_A"; VlanId=101},
        @{Name="102_Server_B"; VlanId=102},
        @{Name="103_Server_C"; VlanId=103},
        @{Name="104_Server_D"; VlanId=104},
        @{Name="105_System"; VlanId=105},
        @{Name="106_Dante_Primary"; VlanId=106},
        @{Name="116_Dante_Secondary"; VlanId=116},
        @{Name="107_KVM"; VlanId=107},
        @{Name="108_NDI"; VlanId=108},
        @{Name="109_Internet"; VlanId=109},
        @{Name="110_Omneo"; VlanId=110},
        @{Name="111_LED"; VlanId=111},
        @{Name="112_MERGE"; VlanId=112}
    )
}

# Build dynamic VLAN set selection
$vlanSets = @{}
$vlanSetNames = @()

# Add loaded sets to the dynamic collection
if ($vlanConfig -and $vlanConfig.vlanSets) {
    foreach ($setName in $vlanConfig.vlanSets.PSObject.Properties.Name) {
        $setData = $vlanConfig.vlanSets.$setName
        $vlanSets[$setName] = @{
            vlans = $setData.vlans
            ipBase = $setData.ipBase
            ipPrompts = $setData.ipPrompts
            ipDefaults = $setData.ipDefaults
        }
        $vlanSetNames += $setName
    }
} else {
    # Fallback to hardcoded sets with new structure
    $vlanSets["4Wall"] = @{
        vlans = @(
            @{Name="196_Engineering"; VlanId=196},
            @{Name="200_d3Net"; VlanId=200},
            @{Name="210_sACN"; VlanId=210},
            @{Name="214_10gMedia"; VlanId=214},
            @{Name="216_10gMedia2"; VlanId=216},
            @{Name="206_LED"; VlanId=206}
        )
        ipBase = "10.{vlan}.{third}.{fourth}"
        ipPrompts = @("third", "fourth")
        ipDefaults = @{third=13}
    }
    $vlanSets["AeonPoint"] = @{
        vlans = @(
            @{Name="10_Server_A"; VlanId=10},
            @{Name="20_Server_B"; VlanId=20},
            @{Name="30_Server_C"; VlanId=30},
            @{Name="40_Server_D"; VlanId=40},
            @{Name="50_System"; VlanId=50},
            @{Name="60_Dante_Primary"; VlanId=60},
            @{Name="65_Dante_Secondary"; VlanId=65},
            @{Name="70_KVM"; VlanId=70},
            @{Name="80_NDI"; VlanId=80},
            @{Name="90_Internet"; VlanId=90}
        )
        ipBase = "10.{vlan}.{third}.{fourth}"
        ipPrompts = @("third", "fourth")
        ipDefaults = @{third=13}
    }
    $vlanSets["Desert"] = @{
        vlans = @(
            @{Name="101_Server_A"; VlanId=101},
            @{Name="102_Server_B"; VlanId=102},
            @{Name="103_Server_C"; VlanId=103},
            @{Name="104_Server_D"; VlanId=104},
            @{Name="105_System"; VlanId=105},
            @{Name="106_Dante_Primary"; VlanId=106},
            @{Name="116_Dante_Secondary"; VlanId=116},
            @{Name="107_KVM"; VlanId=107},
            @{Name="108_NDI"; VlanId=108},
            @{Name="109_Internet"; VlanId=109},
            @{Name="110_Omneo"; VlanId=110},
            @{Name="111_LED"; VlanId=111},
            @{Name="112_MERGE"; VlanId=112}
        )
        ipBase = "192.168.{vlan}.{fourth}"
        ipPrompts = @("fourth")
        ipDefaults = @{}
    }
    $vlanSetNames = @("4Wall", "AeonPoint", "Desert")
}

# Prompt for VLAN set dynamically
Write-Host "Available VLAN sets:"
for ($i = 0; $i -lt $vlanSetNames.Count; $i++) {
    $setName = $vlanSetNames[$i]
    $vlanCount = $vlanSets[$setName].vlans.Count
    Write-Host ('{0}. {1} ({2} VLANs)' -f ($i+1), $setName, $vlanCount)
}

$vlanChoice = Read-Host "Enter choice (1-$($vlanSetNames.Count)):"
$choiceIndex = [int]$vlanChoice - 1

if ($choiceIndex -ge 0 -and $choiceIndex -lt $vlanSetNames.Count) {
    $selectedVlanSet = $vlanSetNames[$choiceIndex]
    $selectedSetData = $vlanSets[$selectedVlanSet]
    $vlans = $selectedSetData.vlans
    $ipBase = $selectedSetData.ipBase
    $ipPrompts = $selectedSetData.ipPrompts
    $ipDefaults = $selectedSetData.ipDefaults
    Write-Host ('Using {0} VLAN set ({1} VLANs).' -f $selectedVlanSet, $vlans.Count)
} else {
    Write-Host "Invalid choice, defaulting to $($vlanSetNames[0])."
    $selectedVlanSet = $vlanSetNames[0]
    $selectedSetData = $vlanSets[$selectedVlanSet]
    $vlans = $selectedSetData.vlans
    $ipBase = $selectedSetData.ipBase
    $ipPrompts = $selectedSetData.ipPrompts
    $ipDefaults = $selectedSetData.ipDefaults
}

# No longer need special case logic - using dynamic IP configuration from JSON

# Prompt for mode
Write-Host "Select mode:"
Write-Host "1. Normal (create switch and adapters, then IP)"
Write-Host "2. IP only (skip creation, only assign IPs)"
Write-Host "3. Nuke all (remove all virtual switches except default)"
$modeChoice = Read-Host 'Enter choice (1, 2, or 3, press Enter for Normal)'
if ($modeChoice -eq "2") {
    $ipOnly = $true
    $nukeAll = $false
} elseif ($modeChoice -eq "3") {
    $ipOnly = $false
    $nukeAll = $true
} else {
    $ipOnly = $false
    $nukeAll = $false
}

# Handle nuke all mode
if ($nukeAll) {
    Write-Host "NUKE ALL MODE: Removing all virtual switches except default switches..."
    Write-Host "WARNING: This will remove ALL user-created virtual switches and their VLAN adapters!"

    $confirm = Read-Host "Are you sure you want to continue? Type 'YES' to confirm"
    if ($confirm -ne "YES") {
        Write-Host "Operation cancelled."
        exit
    }

    # Get all virtual switches
    $allSwitches = Get-VMSwitch
    foreach ($switch in $allSwitches) {
        # Skip default/built-in switches (typically named things like "Default Switch" or starting with certain patterns)
        if ($switch.Name -notlike "*Default*" -and $switch.Name -notlike "vEthernet*" -and $switch.SwitchType -ne "Internal") {
            Write-Host "Removing switch '$($switch.Name)' and all its adapters..."

            # Remove all VLAN adapters associated with this switch
            $adaptersOnSwitch = Get-VMNetworkAdapter -ManagementOS | Where-Object { $_.SwitchName -eq $switch.Name }
            foreach ($adapter in $adaptersOnSwitch) {
                Write-Host "Removing adapter '$($adapter.Name)'..."
                Remove-VMNetworkAdapter -VMNetworkAdapter $adapter -ManagementOS
                Start-Sleep -Seconds $delay
            }

            # Remove the switch
            Write-Host "Removing switch '$($switch.Name)'..."
            Remove-VMSwitch -Name $switch.Name -Force
            Start-Sleep -Seconds $delay
        } else {
            Write-Host "Skipping default/built-in switch '$($switch.Name)'"
        }
    }

    Write-Host "Nuke all operation completed."
    exit
}

if (!$ipOnly) {
    # List current NICs
    Write-Host "Listing available network adapters:"
    $adapters = Get-NetAdapter | Where-Object { $_.Name -notlike "vEthernet*" -and $_.InterfaceDescription -notlike "*Hyper-V*" } | Sort-Object Name
    for ($i = 0; $i -lt $adapters.Count; $i++) {
        $status = if ($adapters[$i].Status -eq "Up") { "Up" } else { "Down" }
        Write-Host "$($i+1). $($adapters[$i].Name) - $($adapters[$i].InterfaceDescription) [Status: $status]"
    }

    # Prompt for selection
    $choice = Read-Host "Select the NIC by number (1-$($adapters.Count))"
    $selectedNic = $adapters[$choice-1].Name
    Write-Host "Selected NIC: $selectedNic"

    # Prompt for virtual switch name
    $switchName = Read-Host "Enter virtual switch name (press Enter for default: vLanSwitch)"
    if ([string]::IsNullOrWhiteSpace($switchName)) { $switchName = "vLanSwitch" }
    Write-Host "Using switch name: $switchName"

    # Deep cleanup: Remove ALL virtual switches bound to the selected physical NIC
    Write-Host "Checking for existing virtual switches bound to '$selectedNic'..."
    $switchesOnNic = Get-VMSwitch | Where-Object { $_.NetAdapterName -eq $selectedNic }
    foreach ($switch in $switchesOnNic) {
        Write-Host "Found existing switch '$($switch.Name)' bound to '$selectedNic'. Cleaning up..."

        # Remove all VLAN adapters associated with this switch
        $adaptersOnSwitch = Get-VMNetworkAdapter -ManagementOS | Where-Object { $_.SwitchName -eq $switch.Name }
        foreach ($adapter in $adaptersOnSwitch) {
            Write-Host "Removing adapter '$($adapter.Name)' from switch '$($switch.Name)'..."
            Remove-VMNetworkAdapter -VMNetworkAdapter $adapter -ManagementOS
            Start-Sleep -Seconds $delay
        }

        # Remove the switch itself
        Write-Host "Removing virtual switch '$($switch.Name)'..."
        Remove-VMSwitch -Name $switch.Name -Force
        Start-Sleep -Seconds $delay
    }

    # Create virtual switch
    Write-Host "Creating virtual switch '$switchName'..."
    # Disable any existing virtual switch binding on the adapter
    Disable-NetAdapterBinding -Name $selectedNic -ComponentID vms_pp -ErrorAction SilentlyContinue
    New-VMSwitch -Name $switchName -NetAdapterName $selectedNic -AllowManagementOS $true
    Start-Sleep -Seconds $delay

    # Add virtual network adapters with delays
    foreach ($vlan in $vlans) {
        Write-Host "Adding virtual adapter '$($vlan.Name)'..."
        Add-VMNetworkAdapter -ManagementOS -Name $vlan.Name -SwitchName $switchName
        Start-Sleep -Seconds $delay
        Write-Host "Setting VLAN ID $($vlan.VlanId) for '$($vlan.Name)'..."
        Set-VMNetworkAdapterVlan -VMNetworkAdapterName $vlan.Name -VlanId $vlan.VlanId -Access -ManagementOS
        Start-Sleep -Seconds $delay
    }
}

# Prompt for IP octets dynamically based on VLAN set configuration
$ipOctets = @{}
foreach ($promptName in $ipPrompts) {
    $defaultValue = $ipDefaults[$promptName]
    if ($defaultValue) {
        $promptText = "Enter the $promptName octet for IP addresses (press Enter for default: $defaultValue)"
        $userInput = Read-Host $promptText
        if ([string]::IsNullOrWhiteSpace($userInput)) {
            $ipOctets[$promptName] = $defaultValue
        } else {
            $ipOctets[$promptName] = $userInput
        }
    } else {
        $promptText = "Enter the $promptName octet for IP addresses"
        $ipOctets[$promptName] = Read-Host $promptText
    }
}

if (!$ipOnly) {
    # Wait 10 seconds after last adapter creation
    Start-Sleep -Seconds 10
}

# Assign IP addresses to virtual adapters using template from JSON
foreach ($vlan in $vlans) {
    # Build IP address from template
    $ip = $ipBase
    $ip = $ip -replace '\{vlan\}', $vlan.VlanId
    foreach ($octetName in $ipOctets.Keys) {
        $ip = $ip -replace "`{$octetName`}", $ipOctets[$octetName]
    }
    
    Write-Host "Setting IP $ip for '$($vlan.Name)'..."

    # Wait for adapter to be available and get fresh adapter info
    $maxRetries = 5
    $retryCount = 0
    $adapter = $null

    while ($retryCount -lt $maxRetries -and $adapter -eq $null) {
        $adapter = Get-NetAdapter | Where-Object { $_.Name -eq $vlan.Name }
        if ($adapter -eq $null) {
            Write-Host "Waiting for adapter '$($vlan.Name)' to be available... ($($retryCount + 1)/$maxRetries)"
            Start-Sleep -Seconds 2
            $retryCount++
        }
    }

    if ($adapter) {
        try {
            # Remove any existing IP addresses first
            $existingIPs = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -ErrorAction SilentlyContinue
            foreach ($existingIP in $existingIPs) {
                if ($existingIP.IPAddress -ne $ip) {
                    Write-Host "Removing existing IP $($existingIP.IPAddress) from '$($vlan.Name)'..."
                    Remove-NetIPAddress -IPAddress $existingIP.IPAddress -Confirm:$false -ErrorAction SilentlyContinue
                }
            }

            # Disable DHCP
            Write-Host "Disabling DHCP for '$($vlan.Name)'..."
            Set-NetIPInterface -InterfaceIndex $adapter.InterfaceIndex -Dhcp Disabled

            # Set static IP
            Write-Host "Assigning static IP $ip to '$($vlan.Name)'..."
            New-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -IPAddress $ip -PrefixLength 24 -ErrorAction Stop

            # Verify the IP was set correctly
            $verifyIP = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex | Where-Object { $_.IPAddress -eq $ip }
            if ($verifyIP) {
                Write-Host "✓ Successfully set IP $ip for '$($vlan.Name)'"
            } else {
                Write-Host "⚠ Warning: IP $ip may not have been set correctly for '$($vlan.Name)'"
            }
        }
        catch {
            Write-Host "✗ Error setting IP for '$($vlan.Name)': $($_.Exception.Message)"
        }
    } else {
        Write-Host "✗ Error: Adapter '$($vlan.Name)' not found after $maxRetries attempts"
    }
}

Write-Host "Script completed."

