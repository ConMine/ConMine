import json

#LifeHistory Trait
data = {
"taxonomy" : {
"synonyms" : {"value" : "value"},
"taxonomic_notes" : {"value": "value"}
},

"iucn_status" : {
"red_list_category" : {"value" : "value"},
"historical_categories" : {"value" : ["pairs"]},
"red_list_notes" : {"value" : "value"}
},

"habitat" : {
"habitats" : [],
"countries_of_occurrence" : {"value" : "value", "unit" : "unit"},
"introduced_range" : {"value" : "value", "unit" : "unit"},
"native_range" : {"value" : "value", "unit" : "unit"},
"endemicity" : {"value" : "value", "unit" : "unit"},
"range_trend" : {"value" : "value", "unit" : "unit"},
"range_description" : {"value" : "value", "unit" : "unit"},
"area_of_occupancy" : {"value" : "value", "unit" : "unit"},
"extent_of_occurrence" : {"value" : "value", "unit" : "unit"},
"range_notes" : {"value" : "value"}
},

"population" : {
"population_size_in_country" : {"value" : "value", "unit" : "unit"},
"population_size_globally" : {"value" : "value", "unit" : "unit"},
"population_trend" : {"value" : "value", "unit" : "unit"},
"population_notes" : {"value" : "value"}
},

"life_history_traits" : {
"lifespan" : {"value" : "value", "unit" : "unit"},
"breeding_lifespan" : {
  "male" : {"value" :  "value", "unit" : "unit"},
  "female" : {"value" :  "value", "unit" : "unit"}
  },
"generation_time" : {"value" :  "value", "unit" : "unit"},
"sexual_maturity_age" : {
  "male" : {"value" :  "value", "unit" : "unit"},
  "female" : {"value" :  "value", "unit" : "unit"}
  },
"clutch_size" : {"value" :  "value", "unit" : "unit"},
"breeding_interval" : {"value" :  "value", "unit" : "unit"},
"time_to_independence" : {"value" :  "value", "unit" : "unit"},
"hatching_time" : {"value" :  "value", "unit" : "unit"},
"breeding_season" : {"value" :  "value", "unit" : "unit"},
"bodymass" : {
"neonate_bodymass" : {"value" :  "value", "unit" : "unit"},
"weaning_bodymass" : {"value" :  "value", "unit" : "unit"},
"adult_bodymass" : {"value" :  "value", "unit" : "unit"}
  }
},

"trade" : {
"year" : {"value" : "value"},
"appendix" : {"value" : "value"},
"importer" : {"value" : "value", "unit" : "unit"},
"exporter" : {"value" : "value", "unit" : "unit"},
"origin" : {"value" : "value", "unit" : "unit"},
"imported_quantity" : {"value" : "value", "unit" : "unit"},
"exported_quantity" : {"value" : "value", "unit" : "unit"},
"term" : {"value" : "value"},
"unit" : {"value" : "value"},
"purpose" : {"value" : "value"},
"source" : {"value" : "value"},
"use_trade_notes" : {"value" : "value"}
},

"conservation" : {
"management_practices" : {"value" : "value", "unit" : "unit"},
"conservation_notes" : {"value" : "value"}
},

"threats" : {
"threats" :  {"value" : "value", "unit" : "unit"},
"scope" :  {"value" : "value", "unit" : "unit"},
"timing" :  {"value" : "value", "unit" : "unit"},
"severity" :  {"value" : "value", "unit" : "unit"},
"score" :  {"value" : "value", "unit" : "unit"},
"threats_notes" : {"value" : "value"}
}
}

with open('Data/template.json', 'w') as outfile:
    json.dump(data, outfile)
