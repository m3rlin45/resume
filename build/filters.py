from collections import defaultdict
from datetime import date

def add_filters(env):
    def DateYearMonthFilter(datestr):
        return date.fromisoformat(datestr).strftime("%B %Y")
    env.filters["DateYearMonth"] = DateYearMonthFilter

    def ConvertSkillsFilter(skills):
        new_skills = defaultdict(list)
        for skill in skills:
            new_skills[skill["name"]].append(skill)

        return [{"name": name, "entries": entries} for name, entries in new_skills.items()]
    env.filters["ConvertSkills"] = ConvertSkillsFilter
                
