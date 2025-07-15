
# Lake Fish Assessment App (DeLFI-Site Replica)

This Shiny application replicates the **DeLFI-Site** module used in
Germany to assess the ecological status of fish communities in lakes,
based on the principles described in the official DeLFI documentation.

🔗 **Live app**: [LakeFishAssessmentApp on
shinyapps.io](https://mmotaferreira.shinyapps.io/LakeFishAssessmentApp/)

📁 **GitHub repository**:
<https://github.com/MMotaFerreira/LakeFishAssessment>

------------------------------------------------------------------------

## 🔍 What is the DeLFI-Site Module?

The **DeLFI-Site** module is a **site-specific assessment system** that
evaluates the ecological status of lakes based on their **fish
community**. It compares the **current fish community** with a
**modelled reference state**, considering species presence and relative
abundance across different habitats and functional guilds.

The system is designed to align with the **EU Water Framework Directive
(WFD)** and is one of two main approaches in the DeLFI system: -
**DeLFI-Type**: a type-specific assessment based on gillnet catches -
**DeLFI-Site**: a site-specific assessment using modelled communities
(this app replicates this one)

------------------------------------------------------------------------

## 📊 Key Features of the App

-   Interactive construction of **reference** and **current** fish
    communities
-   Assignment of **abundance classes** to each species:
    -   `0`: Absent
    -   `1`: Rare
    -   `2`: Regular
    -   `3`: Frequent
-   Calculation of **eight core metrics**:
    -   Number of frequent, regular, and rare species
    -   Presence of habitat and spawning guilds
    -   Abundance of frequent species
    -   Abundance distribution within habitat and spawning guilds
-   Final output as:
    -   **Total score**
    -   **Ecological Quality Ratio (EQR)**
    -   **Ecological status class**: High, Good, Moderate,
        Unsatisfactory, Poor
-   Generation of a **printable report**

------------------------------------------------------------------------

## 🧠 Scientific Background

The fish community modelling follows these principles:

-   **Reference conditions** are constructed from historical records,
    expert judgment, and nearby water bodies.
-   **Current conditions** are modelled using recent (last 6 years)
    fishery and scientific data, with a full habitat representation
    (littoral, benthic, pelagic).
-   Species are grouped into:
    -   **Habitat guilds**: littoral, benthic, epilimnetic, hypolimnetic
    -   **Spawning guilds**: lithophilic, psammophilic,
        phyto-lithophilic, phytophilic
-   The scoring system uses a scale of 1 (poor), 3 (moderate), and 5
    (high) for each metric.
-   The **EQR** is computed from total scores and translated into the
    final ecological status.

------------------------------------------------------------------------

## ▶️ How to Use

1.  **Launch the app** (locally or via
    [shinyapps.io](https://mmotaferreira.shinyapps.io/LakeFishAssessmentApp/)).
2.  **Build fish communities**:
    -   Add species and set their abundance class for both reference and
        current conditions. \### 📐 Abundance Classes

| Abundance Class | Scientific Samples (% number) | Fisheries Statistics (kg/ha) | Informational Sources    |
|-----------------|-------------------------------|------------------------------|--------------------------|
| 3               | \> 5%                         | \> 1 kg/ha                   | frequent, common, plenty |
| 2               | 1–5%                          | 0.1–1 kg/ha                  | regular, steady          |
| 1               | \< 1%                         | \< 0.1 Ind/km²               | rare, sporadic           |
| 0               | –                             | –                            | absent                   |

| Abundance Class | Scientific Samples (% number) | Fisheries Statistics (kg/ha) | Informational Sources    |
|-----------------|-------------------------------|------------------------------|--------------------------|
| 3               | \> 5%                         | \> 1 kg/ha                   | frequent, common, plenty |
| 2               | 1–5%                          | 0.1–1 kg/ha                  | regular, steady          |
| 1               | \< 1%                         | \< 0.1 Ind/km²               | rare, sporadic           |
| 0               | –                             | –                            | –                        |

3.  **Review and adjust functional guilds** for habitat and
    reproduction.
4.  **Run assessment**: Metrics are calculated automatically.
5.  **Download report** (HTML) with full evaluation and class
    boundaries.

------------------------------------------------------------------------

## 🛠️ Technical Requirements

To run the app locally:

1.  Install R and RStudio.
2.  Install required packages: \`\`\`r install.packages(c("shiny",
    "tidyverse", "DT", "readxl", "rmarkdown", "kableExtra")) ´´´ \## 🐛
    Bugs & Suggestions

If you find any bugs, want to suggest improvements, or have questions
about the tool, feel free to reach out:

📧 mario.mota.ferreira(at)gmail.com

## 📄 License

This project is open-source and intended for educational and scientific
use. It is not an official implementation of the DeLFI module and should
not replace regulatory assessments.

## 📚 Acknowledgments

This tool is based on the methodology described in:

```         
Gassner, H., Achleitner, D., Luger, M., Ritterbusch, D., Schubert, M., & Volta, P. (2014). Water framework directive intercalibration technical report: Alpine Lake fish fauna ecological assessment methods. European Commission. Joint Research Centre. Institute for Environment and Sustainability. https://data.europa.eu/doi/10.2788/73280

Ritterbusch et al. 2014
DeLFI-Site documentation – "Short description of the German site-specific Lake Fish Index"
```
