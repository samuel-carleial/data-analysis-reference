# Regular Expressions (regex) in R #############################################


library("stringr")
library("tidyverse")


# patterns ---------------------------------------------------------------------

# line start: ^
# line end: $

# digits: \d
# digits: [:digit:]
# digits: [0-9]

# characters


# hands-on ---------------------------------------------------------------------
# find desired pattern
df %>%
  filter(str_detect(var, pattern))

# find and correct pattern into desired name (new variable)
df %>%
  mutate(new_var= case_when(
    str_detect(var, pattern1) ~ "correct_name1",
    str_detect(var, pattern2) ~ "correct_name2",
    TRUE ~ as.character(var)
  ))

# split string vector in two vectors
df %>%
  separate(original_var, into=("var1","var2"), sep=", ", remove=FALSE, extra="merge")

# split variables, by creating elements into rows
df %>%
  separate_rows(original_var, sep=", ")

# try this
df %>%
  pivot_longer(starts_with(""),
  names_pattern=c(,),
  names_to=c(,))


# END --------------------------------------------------------------------------

session_info()
