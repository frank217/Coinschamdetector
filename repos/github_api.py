from apiserver.settings import g
from repos.data_representations import *


def get_contributors(req):

    repo_name = req.get_repo_id()
    repo = g.get_repo(repo_name)
    contributors = repo.get_contributors()

    l = []
    for c in contributors:
        l.append(
            GithubContributor(c.name(), repo)
        )

    # return PyGithubGetContributorResponse(req)
    return GithubGetContributorResponse(l)
