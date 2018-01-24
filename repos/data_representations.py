class GithubGetContributorRequest(object):
    def __init__(self, repo_id):
        self.repo_id = repo_id

    def get_repo_id(self):
        return self.repo_id


class GithubGetContributorResponse(object):
    def __init__(self, contributors):
        self.contributors = contributors

    def get_contributors(self):
        return self.contributors


class GithubContributor(object):
    def __init__(self, named_user, repo):
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
