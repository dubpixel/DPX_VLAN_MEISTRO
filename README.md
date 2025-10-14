<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!--  *** Thanks for checking out the Best-README-Template. If you have a suggestion that would make this better, please fork the repo and create a pull request or simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again! Now go create something AMAZING! :D -->



<!-- /// d   u   b   p   i   x   e   l  ---  f   o   r   k   ////--v0.5.7 -->
<!--this has additionally been modifed by @dubpixel for hardware use -->
<!--search dpx_vlan_meistro.. search & replace is COMMAND OPTION F -->

<!--this is the version for software -->
<!--todo ** add small product image thats not in a details tag -->
<!--todo ** new software product image? Remove it? -->
<!--igure out how to get the details tag to properly render in jekyll for gihub pages.-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
***
-->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
</div>
<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/dubpixel/dpx_vlan_meistro">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>
<h1 align="center">dpx_vlan_meistro</h1>
<h3 align="center"><i>...setup some vlans n stuff</i></h3>
  <p align="center">
    ...a short description to tease interest
    <br />
     »  
     <a href="https://github.com/dubpixel/dpx_vlan_meistro"><strong>Project Here!</strong></a>
     »  
     <br />
    <a href="https://github.com/dubpixel/dpx_vlan_meistro/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/dubpixel/dpx_vlan_meistro/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
    </p>
</div>
   <br />
<!-- TABLE OF CONTENTS -->
<details>
  <summary><h3>Table of Contents</h3></summary>
<ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>    
    <li><a href="#reflection">Reflection</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
</ol>
</details>
<!-- ABOUT THE PROJECT -->
<details>
<summary><h3>About The Project</h3></summary>
a lengthy description about the project that should probably be many lines. this is where you can get deep about shit and be like oh man its the best hot dog in the universe because i use the koskusko mustart!
</br>

*author(s): // www.dubpixel.tv  - i@dubpixel.tv | other authors* 
</br>
<h3>Images</h3>

### FRONT
![FRONT][product-front]
</details>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With 
 
 * PowerShell
 * Windows Hyper-V
 * GitHub Copilot (AI-assisted development)

<!--
 * [![KiCad][KiCad.org]][KiCad-url]
 * [![Fusion360][Fusion-360]][Autodesk-url]
 * [![FastLed][FastLed.io]][FastLed-url]
 * [![Fusion360][Fusion-360]][Autodesk-url]
 * [![Next][Next.js]][Next-url]
 * [![React][React.js]][React-url]
 * [![Vue][Vue.js]][Vue-url]
 * [![Angular][Angular.io]][Angular-url]
 * [![Svelte][Svelte.dev]][Svelte-url]
 * [![Laravel][Laravel.com]][Laravel-url]
 * [![Bootstrap][Bootstrap.com]][Bootstrap-url]
 * [![JQuery][JQuery.com]][JQuery-url]
 
-->
<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- GETTING STARTED -->

## Getting Started

  ### Prerequisites
  * Windows 10/11 with Hyper-V feature enabled
  * PowerShell 5.1 or higher
  * Administrative privileges
  * At least one physical network adapter
  * Hyper-V PowerShell module (included with Hyper-V)

  ### Installation

  1. Clone the repository
     ```bash
     git clone https://github.com/dubpixel/dpx_vlan_meistro.git
     ```
  2. Navigate to the PowerShell script directory
     ```bash
     cd dpx_vlan_meistro/src
     ```
  3. Ensure Hyper-V is enabled in Windows Features
  4. Run PowerShell as Administrator

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

### Prerequisites
- Windows 10/11 with Hyper-V enabled
- PowerShell with administrative privileges
- Network adapter(s) available for virtual switch creation

### VLAN Configuration
VLAN sets are defined in `src/vlan_sets.json`. You can add new facility configurations by editing this file:

```json
{
  "vlanSets": {
    "YourNewFacility": {
      "vlans": [
        {"Name": "Server_VLAN", "VlanId": 100},
        {"Name": "Client_VLAN", "VlanId": 200}
      ],
      "ipBase": "10.{vlan}.{third}.{fourth}",
      "ipPrompts": ["third", "fourth"],
      "ipDefaults": {"third": 10}
    }
  }
}
```

**IP Configuration Explained:**
- `ipBase`: Template for IP addresses using placeholders like `{vlan}`, `{third}`, `{fourth}`
- `ipPrompts`: List of octets the user will be prompted to enter
- `ipDefaults`: Default values for specific octets (optional)

The script will automatically detect and offer all VLAN sets as options during selection. No code changes required!

### Running the Script

1. **Open PowerShell as Administrator**
   ```powershell
   # Right-click PowerShell and select "Run as Administrator"
   ```

2. **Navigate to the script directory**
   ```powershell
   cd "C:\Path\To\DPX_VLAN_MEISTRO\src"
   ```

3. **Execute the script**
   ```powershell
   .\vlan_mesitro.powershell
   ```

   **Note:** The script displays a comprehensive warning message about potential network disruption. Read it carefully before proceeding.

### Script Workflow

1. **Select VLAN Set**
   - Script automatically loads all available VLAN sets from `vlan_sets.json`
   - Choose from any configured facility (4Wall, Aeon Point, Desert, or custom sets)
   - Each set contains predefined VLAN configurations

2. **Select Mode**
   - **Normal Mode**: Creates virtual switch, adapters, and assigns IPs
   - **IP Only Mode**: Skips creation, only assigns IP addresses to existing adapters
   - **Nuke All Mode**: Removes all virtual switches except default/built-in ones (with confirmation)

3. **Normal Mode Steps**
   - Select physical network adapter from list
   - Enter virtual switch name (defaults to "vLanSwitch")
   - Script creates virtual switch and VLAN adapters with delays

4. **IP Configuration**
   - Enter 3rd octet for IP addresses (defaults to 13 for non-Desert)
   - Enter 4th octet for IP addresses
   - IP formats:
     - Desert: `192.168.<vlan_id>.<4th_octet>`
     - Others: `10.<vlan_id>.<3rd_octet>.<4th_octet>`

5. **Nuke All Mode**
   - Removes all user-created virtual switches and their VLAN adapters
   - Preserves default/built-in switches (like "Default Switch")
   - Requires explicit confirmation by typing "YES"

6. **Completion**
   - Script assigns static IPs to all virtual adapters (in Normal/IP-only modes)
   - Displays progress and completion status

### Example Usage
```
Select VLAN set:
1. 4Wall
2. Aeon Point
3. Desert
Enter choice (1, 2, or 3): 2

Select mode:
1. Normal (create switch and adapters, then IP)
2. IP only (skip creation, only assign IPs)
Enter choice (1 or 2, press Enter for Normal): 1

Listing available network adapters:
1. Ethernet - Intel(R) Ethernet Connection
Select the NIC by number (1-1): 1

Enter virtual switch name (press Enter for default: vLanSwitch):

Enter the 3rd octet for IP addresses (press Enter for default: 13): 13
Enter the 4th octet for IP addresses: 100
```

_For more examples, please refer to the [Documentation](https://example.com)_
<!-- REFLECTION -->
## Reflection

* what did we learn? 
  - _x_
* what do we like/hate?
  - _y_
* what would/could we do differently?
  - _z_
  <!-- ROADMAP -->
## Roadmap

- [ ] Feature 1
    - [ ] Nested Feature

See the [open issues](https://github.com/dubpixel/dpx_vlan_meistro/issues) for a full list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

_Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**._

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Top contributors:
<a href="https://github.com/dubpixel/dpx_vlan_meistro/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=dubpixel/dpx_vlan_meistro" alt="contrib.rocks image" />
</a>

<!-- LICENSE -->
## License

  Distributed under the UNLICENSE License. See `LICENSE.txt` for more information.
<!-- CONTACT -->
## Contact

  ### Joshua Fleitell - i@dubpixel.tv

  Project Link: [https://github.com/dubpixel/dpx_vlan_meistro](https://github.com/dubpixel/dpx_vlan_meistro)

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

<!--
  * [ ]() - the best !
-->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/dubpixel/dpx_vlan_meistro.svg?style=flat-square
[contributors-url]: https://github.com/dubpixel/dpx_vlan_meistro/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/gdubpixel/dpx_vlan_meistro.svg?style=flat-square
[forks-url]: https://github.com/dubpixel/dpx_vlan_meistro/network/members
[stars-shield]: https://img.shields.io/github/stars/dubpixel/dpx_vlan_meistro.svg?style=flat-square
[stars-url]: https://github.com/dubpixel/dpx_vlan_meistro/stargazers
[issues-shield]: https://img.shields.io/github/issues/dubpixel/dpx_vlan_meistro.svg?style=flat-square
[issues-url]: https://github.com/dubpixel/dpx_vlan_meistro/issues
[license-shield]: https://img.shields.io/github/license/dubpixel/dpx_vlan_meistro.svg?style=flat-square
[license-url]: https://github.com/dubpixel/dpx_vlan_meistro/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/jfleitell
[product-front]: images/front.png
[product-rear]: images/rear.png
[product-front-rendering]: images/front_render.png
[product-rear-rendering]: images/rear_render.png
[product-pcbFront]: images/pcb_front.png
[product-pcbRear]: images/pcb_rear.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[KiCad.org]: https://img.shields.io/badge/KiCad-v8.0.6-blue
[KiCad-url]: https://kicad.org 
[Fusion-360]: https://img.shields.io/badge/Fusion360-v4.2.0-green
[Autodesk-url]: https://autodesk.com 
[FastLed.io]: https://img.shields.io/badge/FastLED-v3.9.9-red
[FastLed-url]: https://fastled.io 
