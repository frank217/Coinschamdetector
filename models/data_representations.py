class GetContributorRequest(object):
    def __init__(self):
        pass

    def get_repo_id(self):
        pass


class GetContributorResponse(object):
    def __init__(self):
        pass

    def get_contributors(self):
        pass


class Contributor(object):
    def __init__(self):
        pass

    def get_name(self):
        pass

    def get_num_commits(self):
        pass

    def get_num_lines_added(self):
        pass

    def get_num_lines_deleted(self):
        pass


######
class PyGithubGetContributorRequest(GetContributorRequest):
    def __init__(self, repo_id):
        super(PyGithubGetContributorRequest, self).__init__()
        self.repo_id = repo_id

    def get_repo_id(self):
        return self.repo_id



class PyGithubGetContributorResponse(GetContributorResponse):
    def __init__(self, contributors):
        super(PyGithubGetContributorResponse, self).__init__()
        self.contributors = contributors

    def get_contributors(self):
        return self.contributors


class PyGithubContributor(Contributor):
    def __init__(self, named_user):
        super(PyGithubContributor, self).__init__()
        self.named_user = named_user

    def get_name(self):
        return self.named_user.name()

    def get_num_commits(self):
        return 1

    def get_num_lines_added(self):
        return 10

    def get_num_lines_deleted(self):
        return 1000



class PyGithubContributor2(Contributor):
    def __init__(self, a, b, c, d):
        super(PyGithubContributor2, self).__init__()
        self.a = a
        self.b = b
        self.c = c
        self.d = d

    def get_name(self):
        return self.a

    def get_num_commits(self):
        return self.b

    def get_num_lines_added(self):
        return self.c

    def get_num_lines_deleted(self):
        return self.d
