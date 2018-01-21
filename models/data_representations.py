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
    def __init__(self, named_user, repo):
        super(PyGithubContributor, self).__init__()
        self.named_user = named_user
        self.repo = repo

    def get_name(self):
        return self.named_user.name()

    def get_num_commits(self):
        added_line = 0
        for commit in self.repo.get_commits():
            try:
                if commit.author == self.named_user:
                    added_line += 1
            except:  # There is a case of no name. Commit by user frank as no name.
                pass
        return added_line

    def get_num_lines_added(self):
        added_line = 0
        for commit in self.repo.get_commits():
            try:
                if commit.author == self.named_user:
                    added_line += commit.stats.addtions
            except:
                pass
        return added_line

    def get_num_lines_deleted(self):
        deleted_line = 0
        for commit in self.repo.get_commits():
            try:
                if commit.author == self.named_user:
                    deleted_line += commit.stats.deletions
            except:
                pass

        return deleted_line
#
#
#
# class PyGithubContributor2(Contributor):
#     def __init__(self, a, b, c, d):
#         super(PyGithubContributor2, self).__init__()
#         self.a = a
#         self.b = b
#         self.c = c
#         self.d = d
#
#     def get_name(self):
#         return self.a
#
#     def get_num_commits(self):
#         return self.b
#
#     def get_num_lines_added(self):
#         return self.c
#
#     def get_num_lines_deleted(self):
#         return self.d
