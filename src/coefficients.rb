

module Absorption

  Coefficients = [
    ## Floor
    {
      material: "thin_carpet_concrete",
      coeffs: {
        "125Hz" => 0.10,
        "250Hz" => 0.15,
        "500Hz" => 0.25,
        "1000Hz" => 0.30,
        "2000Hz" => 0.30,
        "4000Hz" => 0.30
      }
    },
    
    {
      material: "wooden_floor_joists",
      coeffs: {
        "125Hz" => 0.15,
        "250Hz" => 0.11,
        "500Hz" => 0.10,
        "1000Hz" => 0.07,
        "2000Hz" => 0.06,
        "4000Hz" => 0.07
      }
    },
  
    ## Ceiling
    {
      material: "mineral_wool_tiles",
      coeffs: {
        "125Hz" => 0.06,
        "250Hz" => 0.40,
        "500Hz" => 0.75,
        "1000Hz" => 0.95,
        "2000Hz" => 0.96,
        "4000Hz" => 0.83
      }
    },
  
    {
      material: "gypsum_plaster_tiles",
      coeffs: {
        "125Hz" => 0.45,
        "250Hz" => 0.70,
        "500Hz" => 0.80,
        "1000Hz" => 0.80,
        "2000Hz" => 0.65,
        "4000Hz" => 0.45
      }
    },
  
    ## Walls
    {
      material: "brickwork",
      coeffs: {
        "125Hz" => 0.05,
        "250Hz" => 0.04,
        "500Hz" => 0.02,
        "1000Hz" => 0.04,
        "2000Hz" => 0.05,
        "4000Hz" => 0.05
      }
    },
  
    {
      material: "plasterboard",
      coeffs: {
        "125Hz" => 0.15,
        "250Hz" => 0.01,
        "500Hz" => 0.06,
        "1000Hz" => 0.04,
        "2000Hz" => 0.04,
        "4000Hz" => 0.05
      }
    },
  
    ## Doors
    {
      material: "wood_hollow_door",
      coeffs: {
        "125Hz" => 0.30,
        "250Hz" => 0.25,
        "500Hz" => 0.15,
        "1000Hz" => 0.10,
        "2000Hz" => 0.10,
        "4000Hz" => 0.07
      }
    },
  
    {
      material: "timber_solid_door",
      coeffs: {
        "125Hz" => 0.14,
        "250Hz" => 0.10,
        "500Hz" => 0.06,
        "1000Hz" => 0.08,
        "2000Hz" => 0.10,
        "4000Hz" => 0.10
      }
    },
  
    ## Windows
    {
      material: "four_mm_glass",
      coeffs: {
        "125Hz" => 0.30,
        "250Hz" => 0.20,
        "500Hz" => 0.10,
        "1000Hz" => 0.07,
        "2000Hz" => 0.05,
        "4000Hz" => 0.02
      }
    },
  
    {
      material: "six_mm_glass",
      coeffs: {
        "125Hz" => 0.10,
        "250Hz" => 0.06,
        "500Hz" => 0.04,
        "1000Hz" => 0.03,
        "2000Hz" => 0.02,
        "4000Hz" => 0.02
      }
    },
  ]
  
end

