#!/bin/bash
vim +"PromptlineSnapshot ~/.promptline.sh" +qall
echo "source ~/.promptline.sh" >> ~/.bash_profile
source ~/.bash_profile
