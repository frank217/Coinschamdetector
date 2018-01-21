from github import Github
from models.data_representations import *

g = Github("2c925c0645f2efd220b66db500f1001c1a24c30f")


def get_contributors(req):

    repo_name = req.get_repo_id()
    repo = g.get_repo(repo_name)
    contributors = repo.get_contributors()

    l = []
    for c in contributors:
        l.append(
            PyGithubContributor(c.name(), repo)
        )

    # return PyGithubGetContributorResponse(req)
    return PyGithubGetContributorResponse(l)


