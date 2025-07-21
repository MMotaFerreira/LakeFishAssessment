library(shiny)
library(DT)
library(tidyverse)
library(kableExtra)

# Data####
# Load species list
species_list <- structure(list(
    Sps = c("Abramis ballerus", "Abramis brama", "Alburnoides bipunctatus", "Alburnos mento", "Alburnus alburnus",
            "Alpinocottus poecilopus", "Ameiurus nebulosus", "Anguilla anguilla", "Aspius aspius",
            "Barbatula barbatula", "Blicca bjoerkna", "Carassius carassius", "Carassius gibelio", "Cobitis taenia",
            "Coregonus albula", "Coregonus sp. 'Ammersee-Kilch'", "Coregonus sp. 'Blaufelchen'", 
            "Coregonus sp. 'Bodensee-Kilch'", "Coregonus sp. 'Gangfisch'", "Coregonus sp. 'Große Maräne'",
            "Coregonus sp. 'Kilch'", "Coregonus sp. 'Ostseeschnäpel'", "Coregonus sp. 'Peipus-Maräne'", 
            "Coregonus sp. 'Sandfelchen'", "Coregonus sp. 'Schaalsee-Maräne'", "Cottus gobio", "Cyprinus carpio",
            "Esox lucius", "Gasterosteus aculeatus", "Gobio gobio", "Gymnocephalus cernua", "Lepomis gibbosus",
            "Leucaspius delineatus", "Leuciscus cephalus", "Leuciscus idus", "Leuciscus leuciscus", "Lota lota", 
            "Misgurnus fossilis", "Neogobius melanostomus", "Oncorhynchus mykiss", "Osmerus eperlanus",
            "Pelecus cultratus", "Perca fluviatilis", "Phoxinus phoxinus", "Platichthys flesus", "Ponticola kessleri",
            "Proterorhinus semilunaris", "Pseudorasbora parva", "Pungitius pungitius", "Rhodeus amarus", 
            "Rutilus meidingeri", "Rutilus rutilus", "Salmo trutta fario", "Salmo trutta lacustris", 
            "Salvelinus alpinus", "Sander lucioperca", "Scardinius erythrophtalmus", "Silurus glanis", 
            "Telestes souffia", "Tinca tinca", "Vimba vimba"), 
    Name_DE = c("Zope", "Blei", "Schneider", "Mairenke/Seelaube", "Ukelei", "Ostgroppe", "Zwergwels", "Aal", "Rapfen",
                "Schmerle", "Güster", "Karausche", "Giebel", "Steinbeißer", "Kleine Maräne", "Ammersee-Kilch", 
                "Blaufelchen", "Bodensee-Kilch", "Gangfisch", "Große Maräne allg.", "Kilch", "Ostseeschnäpel", 
                "Peipus-Maräne", "Sandfelchen", "Schaalsee-Maräne", "Westgroppe", "Karpfen", "Hecht", "Dreist. Stichling",
                "Gründling", "Kaulbarsch", "Sonnenbarsch", "Moderlieschen", "Döbel", "Aland", "Hasel", "Quappe",
                "Schlammpeitzger", "Schwarzmund-Grundel", "Regenbogenforelle", "Stint", "Ziege", "Barsch", "Elritze", 
                "Flunder", "Kessler-Grundel", "Marmorgrundel", "Blaubandbärbling", "Zwergstichling", "Bitterling", 
                "Perlfisch", "Plötze", "Bachforelle", "Seeforelle", "Seesaibling", "Zander", "Rotfeder", "Wels", "Strömer",
                "Schleie", "Zährte"), 
    Name_EN = c("Blue bream", "Bream", "Schneider", "Danube bleak", "Bleak", "Alpine bullhead", "Brown bullhead", "Eel",
                "Asp", "Stone loach", "White bream", "Crucian carp", "Prussian carp", "Spined loach", "Vendace", 
                "Whitefish Ammersee-Kilch", "Whitefish Blaufechen", "Whitefish Bodensee-Kilch", "Whitefish Gangfisch",
                "Whitefish Große Maräne allg.", "Whitefish Kilch", "Whitefish Ostseeschnäpel", "Whitefish Ostseeschnäpel",
                "Whitefish Sandfelchen", "Whitefish Schaalsee-Maräne", "Bullhead", "Carp", "Pike", "Three-spined stickleback", 
                "Gudgeon", "Ruffe", "Pumpkinseed", "Belica", "Chub", "Orfe", "Dace", "Burbot", "Weatherfish", "Round goby", 
                "Rainbow trout", "European smelt", "Sichel", "Perch", "Eurasian minnow", "European flounder", "Bighead goby",
                "Tubenose goby", "Stone moroko", "Ninespine stickleback", "Bitterling", "Black Sea roach", "Roach", 
                "Brown trout (river form)", "Brown trout (lake form)", "Artic char", "Pikeperch", "Rudd", "Catfish", 
                "Vairone", "Tench", "Vimba bream"), 
    Status = c("Native", "Native", "Native", "Native", "Native", "Native", "Exotic", "Native", "Native", "Native", 
               "Native", "Native", "Native", "Native", "Exotic", "Native", "Native", "Native", "Native", "Native", 
               "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", 
               "Native", "Exotic", "Native", "Native", "Exotic", "Native", "Native", "Native", "Exotic", "Stocked",
               "Native", "Native", "Native", "Native", "Native", "Exotic", "Exotic", "Exotic", "Native", "Native", 
               "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native", "Native"),
    Habitat_Guild = c("Littoral", "Littoral", "Littoral", "Epilimnetic", "Littoral", "Profundal", "Littoral", "Littoral",
                      "Epilimnetic", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", "Hypoplimnic", "Profundal",
                      "Hypoplimnic", "Profundal", "Hypoplimnic", "Profundal", "Profundal", "Littoral", "Hypoplimnic",
                      "Profundal", "Profundal", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", 
                      "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral", 
                      "Littoral", "Epilimnetic", "Epilimnetic", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral",
                      "Littoral", "Littoral", "Littoral", "Profundal", "Littoral", "Littoral", "Epilimnetic", "Hypoplimnic", 
                      "Epilimnetic", "Littoral", "Littoral", "Littoral", "Littoral", "Littoral"),
    Spawning_Guild = c("Phyto-lithophilic", "Phyto-lithophilic", "Lithophilic", "Lithophilic", "Phyto-lithophilic", 
                       "Lithophilic", "Phyto-lithophilic", NA, "Lithophilic", "Psammophil", "Phytophilic", "Phytophilic",
                       "Phyto-lithophilic", "Phytophilic", "Lithophilic", "Lithophilic", "Lithophilic", 
                       "Lithophilic", "Lithophilic", "Lithophilic", "Lithophilic", "Lithophilic", "Lithophilic", "Lithophilic", 
                       "Lithophilic", "Lithophilic", "Phytophilic", "Phytophilic", "Phytophilic", "Psammophil", 
                       "Phyto-lithophilic", "Lithophilic", "Phytophilic", "Lithophilic", "Phyto-lithophilic", "Lithophilic",
                       "Lithophilic", "Phytophilic", "Lithophilic", "Lithophilic", "Lithophilic", "Lithophilic",
                       "Phyto-lithophilic", "Phytophilic", NA, "Lithophilic", "Lithophilic", "Phytophilic", NA, "Psammophil",
                       "Lithophilic", "Phyto-lithophilic", "Lithophilic", "Lithophilic", "Lithophilic", "Phyto-lithophilic",
                       "Phytophilic", "Phytophilic", "Lithophilic", "Phytophilic", "Lithophilic")), 
    class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -61L))


# Functions####
## Compute metrics function####
compute_metrics <- function(df) {
    df <- df |> mutate(
        RefPresent = Reference > 0,
        IsPresent = Current > 0
    )
    
    #### 1. Frequent Species
    freq <- df |> filter(Reference == 3)
    # freq_score <- if (all(freq$IsPresent)) 5 else 1
    freq_score <- case_when(nrow(freq) == 0 ~ NA_real_,
                            all(freq$IsPresent) ~ 5,
                            TRUE ~ 1)
    
    #### 2. Regular Species
    regular <- df |> filter(Reference == 2)
    reg_present_pct <- if (nrow(regular) > 0) {
        mean(regular$IsPresent) * 100
    } else NA
    reg_score <- case_when(
        is.na(reg_present_pct) ~ NA_real_,
        reg_present_pct > 90 ~ 5,
        reg_present_pct >= 75 ~ 3,
        TRUE ~ 1
    )
    
    #### 3. Rare Species
    rare <- df |> filter(Reference == 1)
    rare_present_pct <- if (nrow(rare) > 0) {
        mean(rare$IsPresent) * 100
    } else NA
    rare_score <- case_when(
        is.na(rare_present_pct) ~ NA_real_,
        rare_present_pct > 50 ~ 5,
        rare_present_pct >= 25 ~ 3,
        TRUE ~ 1
    )
    
    #### 4. Habitat Guilds
    ref_hab_groups <- df |> 
        filter(Reference > 0) |> 
        group_by(HabitatGuild) |> 
        summarise(RefSpecies = n(), .groups = "drop")
    
    cur_hab_groups <- df |> 
        filter(Current > 0) |> 
        group_by(HabitatGuild) |> 
        summarise(CurSpecies = n(), .groups = "drop")
    
    # Join and handle missing current guilds
    hab_guilds <- ref_hab_groups |> 
        left_join(cur_hab_groups, by = "HabitatGuild") |> 
        mutate(CurSpecies = replace_na(CurSpecies, 0),
               MissingSpecies = RefSpecies - CurSpecies)
    
    # Count absent guilds (CurSpecies == 0)
    hab_n_absent_guilds <- sum(hab_guilds$CurSpecies == 0)
    
    # Count guilds that are absent and missing > 1 species
    hab_n_absentMS_guilds <- sum(hab_guilds$CurSpecies == 0 & hab_guilds$MissingSpecies > 1)
    
    # Apply corrected scoring rule
    habitat_score <- case_when(
        hab_n_absent_guilds == 0 & hab_n_absentMS_guilds == 0 ~ 5,
        hab_n_absent_guilds == 1 & hab_n_absentMS_guilds == 0 ~ 3,
        TRUE ~ 1
    )
    
    #### 5. Spawning Guilds
    ref_spaw_groups <- df |> 
        filter(Reference > 0) |> 
        group_by(SpawningGuild) |> 
        summarise(RefSpecies = n(), .groups = "drop")
    
    cur_spaw_groups <- df |> 
        filter(Current > 0) |> 
        group_by(SpawningGuild) |> 
        summarise(CurSpecies = n(), .groups = "drop")
    
    # Join and handle missing current guilds
    spaw_guilds <- ref_spaw_groups |> 
        left_join(cur_spaw_groups, by = "SpawningGuild") |> 
        mutate(CurSpecies = replace_na(CurSpecies, 0),
               MissingSpecies = RefSpecies - CurSpecies)
    
    # Count truly absent guilds (CurSpecies == 0)
    spaw_n_absent_guilds <- sum(spaw_guilds$CurSpecies == 0)
    
    # Count guilds that are absent and missing > 1 species
    spaw_n_absentMS_guilds <- sum(spaw_guilds$CurSpecies == 0 & spaw_guilds$MissingSpecies > 1)
    
    # Apply corrected scoring rule
    spawning_score <- case_when(
        spaw_n_absent_guilds == 0 & spaw_n_absentMS_guilds == 0 ~ 5,
        spaw_n_absent_guilds == 1 & spaw_n_absentMS_guilds == 0 ~ 3,
        TRUE ~ 1
    )
    
    ### 6. Frequent species abundance
    if (nrow(freq) > 0) {
        freq_current_still_freq_pct <- mean(freq$Current >= 3) * 100
        freq_abund_score <- case_when(
            freq_current_still_freq_pct == 100 ~ 5,
            freq_current_still_freq_pct >= 50 ~ 3,
            TRUE ~ 1
        )
    } else {
        freq_abund_score <- NA
    }
    
    #### 7. Habitat Guild score
    habitat_Guild_score <- df |> 
        Habitat_Guild_Score() |> 
        group_by("Habitat guild") |> 
        summarise(Score = mean(Score)) |> 
        pull(Score) |> 
        mean()
    
    habitat_G_Score <-  case_when(habitat_Guild_score> 4 ~ 5,
                                  habitat_Guild_score >= 2 & habitat_Guild_score <= 4 ~ 3,
                                  habitat_Guild_score < 2 ~ 1)
    
    #### 7. Spawning Guild score
    spawning_Guild_score <- df |> 
        spawning_Guild_Score() |> 
        group_by("Spawning guild") |> 
        summarise(Score = mean(Score)) |> 
        pull(Score) |> 
        mean()
    
    spawning_G_Score <-  case_when(spawning_Guild_score> 4 ~ 5,
                                  spawning_Guild_score >= 2 & spawning_Guild_score <= 4 ~ 3,
                                  spawning_Guild_score < 2 ~ 1)
    
    #### Return summary
    tibble::tibble(
        Metric = c("Frequent Species", "Regular Species", "Rare Species",
                   "Habitat Guilds", "Spawning Guilds", "Frequent species ab.", 
                   "Habitat Guild Score", "Spawning Guild Score"),
        Score = c(freq_score, reg_score, rare_score, habitat_score, spawning_score,
                  freq_abund_score, habitat_G_Score, spawning_G_Score)
    )
}

## Breakdown of presence/absence####
generate_breakdown_summary <- function(df) {
    df <- df |> mutate(IsPresent = Current > 0)
    
    #### Species class summary
    species_classes <- df |> filter(Reference > 0) |> mutate(
        Category = case_when(
            Reference == 3 ~ "Frequent",
            Reference == 2 ~ "Regular",
            Reference == 1 ~ "Rare"
        )
    )
    
    spec_summary <- species_classes |> group_by(Category) |>
        summarise(
            Reference_n = n(),
            Present_n = sum(IsPresent & Reference > 0 ),
            Missing = paste(Species[!IsPresent], collapse = ", "),
            .groups = "drop"
        )
    
    #### Habitat guild summary
    ref_hab_guilds <- df |> filter(Reference > 0) |> distinct(HabitatGuild) |> pull()
    cur_hab_guilds <- df |> filter(Current > 0 & Reference > 0) |> distinct(HabitatGuild) |> pull()
    missing_hab_guilds <- setdiff(ref_hab_guilds, cur_hab_guilds)
    
    hab_summary <- tibble::tibble(
        Category = "Habitat Guilds",
        Reference_n = length(ref_hab_guilds),
        Present_n = length(cur_hab_guilds),
        Missing = paste(missing_hab_guilds, collapse = ", ")
    )
    
    #### Spawning guild summary
    ref_spawn_guilds <- df |> filter(Reference > 0) |> distinct(SpawningGuild) |> pull()
    ref_spawn_guilds <- ref_spawn_guilds[!is.na(ref_spawn_guilds)]
    cur_spawn_guilds <- df |> filter(Current > 0 & Reference > 0) |> distinct(SpawningGuild) |> pull()
    cur_spawn_guilds <- cur_spawn_guilds[!is.na(cur_spawn_guilds)]
    missing_spawn_guilds <- setdiff(ref_spawn_guilds, cur_spawn_guilds)
    
    spawn_summary <- tibble::tibble(
        Category = "Spawning Guilds",
        Reference_n = length(ref_spawn_guilds),
        Present_n = length(cur_spawn_guilds),
        Missing = paste(missing_spawn_guilds, collapse = ", ")
    )
    
    #### Combine everything
    full_summary <- bind_rows(
        spec_summary,
        hab_summary,
        spawn_summary
    ) |> 
        mutate("%" = Present_n / Reference_n * 100) |> 
        relocate("%", .after = Present_n)
    
    return(full_summary)
}

## Frequent species abundance breakdown####
Frequent_sps_ab_breakdown <- function(df){
    Out <- df |> 
        filter(Reference == 3) |> 
        summarise(Reference_n = n(),
                  Present_n = sum(Current == 3)) |> 
        mutate("%" = Present_n / Reference_n * 100)
    
    return(Out)
}

## Habitat Guild Score####
# Habitat_Guild_Score <- function(df){
#     Out <- df |> 
#         # filter(Reference > 0) |> 
#         group_by(HabitatGuild, Ab_Class = Reference) |> 
#         summarise(N_Ref = n()) |> 
#         left_join(df |> 
#                       group_by(HabitatGuild, Ab_Class = Current) |>
#                       summarise(N_Presence = n()) |> 
#                       pivot_wider(names_from = Ab_Class, values_from = N_Presence, values_fill = 0) |> 
#                       pivot_longer(cols = -HabitatGuild, 
#                                    names_to = "Ab_Class", values_to = "N_Presence") |>
#                       mutate(Ab_Class = as.double(Ab_Class))) |> 
#         mutate(Quoficient = N_Ref/N_Presence,
#                AbsLog = abs(log10(Quoficient)),
#                Score = case_when(N_Presence == 0 ~ 1,
#                                  AbsLog <= .33 ~ 5,
#                                  AbsLog > .33 & AbsLog <= .66 ~ 3,
#                                  AbsLog > .66 ~ 1)) |> 
#         rename("Habitat guild" = "HabitatGuild", "Abundance Class" = "Ab_Class",
#                "# Sps. Ref." = "N_Ref", "# Sps." = N_Presence, "|log(Q.)|" = AbsLog)
#     
#     
#     return(Out)
# }

Habitat_Guild_Score <- function(df) {
    # Create Reference Summary
    ref_summary <- df |> 
        filter(Reference > 0) |> 
        group_by(HabitatGuild, Ab_Class = Reference) |> 
        summarise(N_Ref = n(), .groups = "drop")
    
    # Create Current Summary (even if Current == 0 is not counted)
    cur_summary <- df |> 
        filter(Current > 0) |> 
        group_by(HabitatGuild, Ab_Class = Current) |> 
        summarise(N_Presence = n(), .groups = "drop")
    
    # Join, fill missing current values with 0
    combined <- ref_summary |> 
        full_join(cur_summary, by = c("HabitatGuild", "Ab_Class")) |> 
        mutate(
            N_Ref = replace_na(N_Ref, 0),
            N_Presence = replace_na(N_Presence, 0)
        ) |> 
        # If N_Ref == 0, we drop it — no reference basis
        filter(N_Ref > 0) |> 
        mutate(
            Quotient = N_Presence / N_Ref,
            AbsLog = abs(log10(Quotient)),  # avoid log10(0)
            Score = case_when(
                N_Presence == 0 ~ 1,
                AbsLog <= 0.33 ~ 5,
                AbsLog <= 0.66 ~ 3,
                TRUE ~ 1
            )
        ) |> 
        rename(
            "Habitat Guild" = HabitatGuild,
            "Abundance Class" = Ab_Class,
            "# Sps. Ref." = N_Ref,
            "# Sps." = N_Presence,
            "|log(Q.)|" = AbsLog
        )
    
    return(combined)
}

## Spawning Guild Score####
spawning_Guild_Score <- function(df) {
    # Create Reference Summary
    ref_summary <- df |> 
        filter(Reference > 0,
               !is.na(SpawningGuild)) |> 
        group_by(SpawningGuild, Ab_Class = Reference) |> 
        summarise(N_Ref = n(), .groups = "drop")
    
    # Create Current Summary (even if Current == 0 is not counted)
    cur_summary <- df |> 
        filter(Current > 0,
               !is.na(SpawningGuild)) |> 
        group_by(SpawningGuild, Ab_Class = Current) |> 
        summarise(N_Presence = n(), .groups = "drop")
    
    # Join, fill missing current values with 0
    combined <- ref_summary |> 
        full_join(cur_summary, by = c("SpawningGuild", "Ab_Class")) |> 
        mutate(
            N_Ref = replace_na(N_Ref, 0),
            N_Presence = replace_na(N_Presence, 0)
        ) |> 
        # If N_Ref == 0, we drop it — no reference basis
        filter(N_Ref > 0) |> 
        mutate(
            Quotient = N_Presence / N_Ref,
            AbsLog = abs(log10(Quotient)),  # avoid log10(0)
            Score = case_when(
                N_Presence == 0 ~ 1,
                AbsLog <= 0.33 ~ 5,
                AbsLog <= 0.66 ~ 3,
                TRUE ~ 1
            )
        ) |> 
        rename(
            "Spawning Guild" = SpawningGuild,
            "Abundance Class" = Ab_Class,
            "# Sps. Ref." = N_Ref,
            "# Sps." = N_Presence,
            "|log(Q.)|" = AbsLog
        )
    
    return(combined)
}

## Total Score & EQR####
EQR <- function(df){
    Score <- compute_metrics(df)
    
    Total_score <- sum(Score$Score, na.rm = T)
    
    N_score <- sum(!is.na(Score$Score))
    
    EQR <- (Total_score - N_score) / (N_score * 5 - N_score)
    
    Assessment <- case_when(EQR >= .85 ~ "High",
                                EQR < .85 & EQR >= .69 ~ "Good",
                                EQR < .69 & EQR >= .5 ~ "Moderate",
                                EQR < .5 & EQR >= .25 ~ "Unsatisfactory",
                                EQR < .25 ~ "Poor")
    
    Out <- tibble("Total score" = Total_score,
                  "N metrics" = N_score,
                  "EQR" = EQR,
                  "Assement" = Assessment)
    return(Out)
}

# UI####
ui <- fluidPage(
    titlePanel("Lake Fish Assessment Tool"),
    
    sidebarLayout(
        sidebarPanel(
            textInput("evaluator", "Name of Evaluator"),
            textInput("lake_name", "Lake Name"),
            numericInput("year", "Year of Assessment", value = 2025, min = 1900, max = 2100),
            
            wellPanel(
                tags$h4("Select Species from list"),
                
                selectInput("species", "Select Fish Species",
                        choices = species_list$Sps),
                
                numericInput("reference_abund", "Reference Abundance", value = 0, min = 0, max = 3),
                
                numericInput("current_abund", "Current Abundance", value = 0, min = 0, max = 3),
                
                actionButton("add_entry", "Add Species", icon = icon("plus"))),
            
            wellPanel(
                tags$h4("Add New Species"),
                
                textInput("new_species", "Species Name"),
                
                textInput("new_name", "Common Name"),
                
                selectInput("new_status", "Status", choices = c("Native", "Stocked", "Exotic")),
                
                selectInput("new_habitat", "Habitat Guild", choices = c(
                    "Littoral", "Benthic", "Epilimnetic", "Hypolimenetic")),
                
                selectInput("new_spawn", "Spawning Guild", choices = c(
                    "Lithophilic", "Psammophilic", "Phyto-lithophilic", "Phytophilic")),
                
                numericInput("new_reference", "Reference Abundance", value = 0, min = 0, max = 3, step = 1),
                numericInput("new_current", "Current Abundance", value = 0, min = 0, max = 3, step = 1),
                
                actionButton("add_species", "Add Species", icon = icon("plus"))
            )
            
            
        ),
        
        mainPanel(
            h4("Fish Community Assessment Table"),
            DTOutput("community_table"),
            br(),
            h3("Presence/Absence assessment"),
            h4("Breakdown of Reference vs. Current State"),
            DTOutput("breakdown_table") ,
            br(),
            h3("Abudance metrics"),
            br(),
            h4("Frequent species"),
            DTOutput("FreqSps_ab_breakdown_table"),
            br(),
            h4("Habitat Guild Scores"),
            DTOutput("Habitat_G_Score_table"),
            h4("Spawning Guild Scores"),
            DTOutput("spawning_G_Score_table"),
            h3("Assessment"),
            h4("Metric Scores"),
            DTOutput("metrics_table"),
            h3("Tota Score and EQR"),
            DTOutput("EQR_table"),
            downloadButton("download_report", "Download Report"),
            
        )
    )
)

# Server####
server <- function(input, output, session) {
    # Reactive storage
    # Initialize empty community table
    community_data <- reactiveVal(data.frame(
        Species = character(),
        Name = character(),
        Status = character(),
        HabitatGuild = character(),
        SpawningGuild = character(),
        Reference = numeric(),
        Current = numeric(),
        stringsAsFactors = FALSE
    ))
    
    ### Add selected species from list
    observeEvent(input$add_entry, {
        current_data <- community_data()
        
        # Check for duplicate
        if (input$species %in% current_data$Species) {
            showModal(modalDialog(
                title = "Duplicate Species",
                paste("The species", input$species, "is already in the list."),
                easyClose = TRUE
            ))
            return(NULL)
        }
        
        # Fetch species info from species_list
        species_info <- species_list |> filter(Sps == input$species)
        
        if (nrow(species_info) > 0) {
            new_row <- data.frame(
                Species = input$species,
                Name = species_info$Name_EN,
                Status = species_info$Status,
                HabitatGuild = species_info$Habitat_Guild,
                SpawningGuild = species_info$Spawning_Guild,
                Reference = input$reference_abund,
                Current = input$current_abund,
                stringsAsFactors = FALSE
            )
            
            community_data(bind_rows(current_data, new_row))
        }
    })
    
    ### Add user-defined species
    observeEvent(input$add_species, {
        current_data <- community_data()
        
        # Check for duplicate
        if (input$new_species %in% current_data$Species) {
            showModal(modalDialog(
                title = "Duplicate Species",
                paste("The species", input$new_species, "is already in the list."),
                easyClose = TRUE
            ))
            return(NULL)
        }
        
        # Build row
        new_row <- data.frame(
            Species = input$new_species,
            Name = input$new_name,
            Status = input$new_status,
            HabitatGuild = input$new_habitat,
            SpawningGuild = input$new_spawn,
            Reference = input$new_reference,
            Current = input$new_current,
            stringsAsFactors = FALSE
        )
        
        community_data(bind_rows(current_data, new_row))
    })
    
    
    
    output$community_table <- renderDT({
        df <- community_data()
        
        if (nrow(df) > 0) {
            df$Remove <- paste0(
                '<button id="remove_', seq_len(nrow(df)), '" class="btn btn-danger btn-sm">Remove</button>'
            )
        }
        
        datatable(
            df,
            escape = FALSE,
            selection = "none",
            rownames = FALSE,
            options = list(dom = 't',
                           pageLength = 20,
                           autoWidth = TRUE)
        )
    })
    
    observe({
        input$community_table_cell_clicked
        invalidateLater(500, session)
        
        # Get button click ID
        click <- input$community_table_cell_clicked
        if (is.null(click$value)) return()
        
        clicked_value <- click$value
        if (startsWith(clicked_value, "<button id=\"remove_")) {
            row_id <- as.integer(gsub(".*remove_(\\d+).*", "\\1", clicked_value))
            df <- community_data()
            if (!is.na(row_id) && row_id <= nrow(df)) {
                df <- df[-row_id, ]
                community_data(df)
            }
        }
    })
    
    #metric table
    output$metrics_table <- renderDT({
        req(nrow(community_data()) > 0)
        compute_metrics(community_data())
    })
    
    #breakdown table
    # output$breakdown_table <- renderDataTable({
    #     req(nrow(community_data()) > 0)
    #     generate_breakdown_summary(community_data())
    # })
    
    output$breakdown_table <- renderDataTable({
        req(nrow(community_data()) > 0)
        datatable(generate_breakdown_summary(community_data()),
                  options = list(
                      pageLength = 5,
                      autoWidth = TRUE
                  ),
                  rownames = FALSE,
                  ) |> formatRound("%", digits = 2)
    })
    
    
    #breakdown frequent species table
    output$FreqSps_ab_breakdown_table <- renderDT({
        req(nrow(community_data() |> 
                     filter(Reference == 3)) > 0)
        datatable(Frequent_sps_ab_breakdown(community_data()),
                  options = list(
                      autoWidth = TRUE
                  ),
                  rownames = FALSE,
        ) 
    })
    
    #Habitat guilds score
    output$Habitat_G_Score_table <- renderDT({
        req(nrow(community_data()) > 0)
        datatable(Habitat_Guild_Score(community_data()),
                  options = list(
                      autoWidth = TRUE
                  ),
                  rownames = FALSE,
        ) |> formatRound(c("Quotient", "|log(Q.)|"), digits = 2)
    })
    
    #Spawning guilds score
    output$spawning_G_Score_table <- renderDT({
        req(nrow(community_data()) > 0)
        datatable(spawning_Guild_Score(community_data()),
                  options = list(
                      autoWidth = TRUE
                  ),
                  rownames = FALSE
        ) |> formatRound(c("Quotient", "|log(Q.)|"), digits = 2)
    })
    
    #EQR & Total Score
    output$EQR_table <- renderDT({
        req(nrow(community_data()) > 0)
        datatable(EQR(community_data()),
                  options = list(
                      autoWidth = TRUE
                  ),
                  rownames = FALSE) |> 
            formatRound("EQR", digits = 2)
        
    })
    
    #Rmarkdown output
    output$download_report <- downloadHandler(
        filename = function() {
            paste0("Lake_Fish_Report_", input$lake_name, "_", input$year, ".html")
        },
        content = function(file) {
            rmarkdown::render("report_template05.Rmd",
                              params = list(
                                  evaluator = input$evaluator,
                                  lake = input$lake_name,
                                  year = input$year,
                                  Fish_table = community_data(),
                                  breakdown_table = generate_breakdown_summary(community_data()),
                                  FreqSps_ab_table = Frequent_sps_ab_breakdown(community_data()),
                                  Habitat_Guild_table = Habitat_Guild_Score(community_data()),
                                  Spawning_Guild_table = spawning_Guild_Score(community_data()),
                                  metrics_table = compute_metrics(community_data()),
                                  EQR_table = EQR(community_data())
                              ),
                              output_file = file)
        }
    )
    
}

# shinyApp####
shinyApp(ui, server)
