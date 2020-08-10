library("workflowr")
?workflowr

wflow_git_config()
wflow_git_config(user.name="samuel-carleial", user.email="samuel.carleial@gmail.com")

setwd("~/git_projects/data-analysis-reference/[reference_guide] R/workflow")

wflow_start(name="workflow test",
            directory=getwd(),
            existing=TRUE,
            user.name="samuel-carleial",
            user.email="samuel.carleial@gmail.com")

wflow_build()
wflow_status()
wflow_git_config()
wflow_git_commit("analysis/bunga.txt", "Update bunga file")
wflow_git_commit(all=TRUE)

# Publish the site, i.e. version the source code and HTML results
wflow_publish("analysis/*", "Start my new project")
wflow_publish("analysis/*", "bunga added")

wflow_git_push()
