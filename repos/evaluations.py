class EvaluationRule(object):

    def __init__(self):
        pass

    def evaluate(self, evaluation_objects):
        pass


class ContributorEvaluationRule(EvaluationRule):

    def __init__(self, hard_limit):
        super(ContributorEvaluationRule, self).__init__()
        self.hard_limit = hard_limit

    def evaluate(self, contributors):
        qualified_contributors = sum(
            map(
                lambda x: x.get_num_lines_added() + x.get_num_lines_deleted() > 500,
                contributors
            )
        )
        return 1 if qualified_contributors > self.hard_limit else 0
