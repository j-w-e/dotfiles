# Preamble ----------------------------------------------------------------
library(tidyverse)

# read the data -----------------------------------------------------------
data <- read_delim("~/.config/key_log.txt", 
                   col_names = FALSE, 
                   delim = "\n",
                   quote = "")
data %>% 
  count(X1) %>% 
  # filter(!str_detect(X1, "<[a-z]*_?[a-z]*>")) %>% # Remove shortcut keys
  # filter(str_detect(X1, "<[a-z]*_?[a-z]*>")) %>% # Only shortcut keys
  # filter(!str_detect(X1, "<cmd>")) %>% # Remove cmd keys
  # filter(!str_detect(X1, "<ctrl>")) %>% # Remove ctrl keys
  # filter(!str_detect(X1, "<alt>")) %>% # Remove alt keys
  # filter(!str_detect(X1, "^[a-z]$")) %>% # Remove lowercase letters
  # filter(!str_detect(X1, "^[A-Z]$")) %>% # Remove capital letters
  # filter(str_detect(X1, "^[-v'b\"_qz]$")) %>% 
  slice_max(n, n = 50, with_ties = FALSE) %>% # keep only the most common
  ggplot() +
  geom_bar(aes(x = reorder(X1, -n), y = n), stat = "identity") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = -30, hjust = 0, vjust = 1)) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank())
