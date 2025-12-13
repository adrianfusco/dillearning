from models.concept import Concept
from models.conversation import Conversation
from models.course import Course
from models.exercise import Exercise
from models.language import Language
from models.token import TokenBlocklist
from models.unit import Unit
from models.user import User
from models.user_exercise_progress import UserExerciseProgress
from models.user_unit_progress import UserUnitProgress
from sqladmin import Admin, ModelView


class UserAdmin(ModelView, model=User):
    column_list = [User.id, User.name, User.email]
    column_searchable_list = [User.name, User.email]


class CourseAdmin(ModelView, model=Course):
    column_list = [Course.id, Course.title, Course.code]
    column_details_list = [Course.id, Course.title, Course.code, Course.units]
    column_searchable_list = [Course.title, Course.code]


class UnitAdmin(ModelView, model=Unit):
    column_list = [Unit.id, Unit.title, Unit.order, "course.title"]
    column_details_list = [
        Unit.id,
        Unit.title,
        Unit.order,
        "course.title",
        Unit.concepts,
    ]
    column_searchable_list = [Unit.title, "course.title"]


class ConceptAdmin(ModelView, model=Concept):
    column_list = [
        Concept.id,
        Concept.title,
        Concept.explanation,
        "unit.title",
        "unit.course.title",
    ]
    column_details_list = [
        Concept.id,
        Concept.title,
        Concept.explanation,
        "unit.title",
        "unit.course.title",
        Concept.exercises,
    ]
    column_searchable_list = [Concept.title, "unit.title"]


class ExerciseAdmin(ModelView, model=Exercise):
    column_list = [Exercise.id, Exercise.prompt, Exercise.type, "concept.title"]
    column_searchable_list = [Exercise.prompt, "concept.title"]


class LanguageAdmin(ModelView, model=Language):
    column_list = [Language.id, Language.name]
    column_searchable_list = [Language.name]


class ConversationAdmin(ModelView, model=Conversation):
    column_list = [Conversation.id, Conversation.user_id, Conversation.role]


class TokenBlocklistAdmin(ModelView, model=TokenBlocklist):
    column_list = [TokenBlocklist.id, TokenBlocklist.jti]


class UserExerciseProgressAdmin(ModelView, model=UserExerciseProgress):
    column_list = [
        UserExerciseProgress.user_id,
        UserExerciseProgress.exercise_id,
        UserExerciseProgress.completed,
    ]


class UserUnitProgressAdmin(ModelView, model=UserUnitProgress):
    column_list = [
        UserUnitProgress.user_id,
        UserUnitProgress.unit_id,
        UserUnitProgress.completed,
    ]


def setup_admin(app, engine):
    admin = Admin(app, engine)
    admin.add_view(UserAdmin)
    admin.add_view(CourseAdmin)
    admin.add_view(UnitAdmin)
    admin.add_view(ConceptAdmin)
    admin.add_view(ExerciseAdmin)
    admin.add_view(LanguageAdmin)
    admin.add_view(ConversationAdmin)
    admin.add_view(TokenBlocklistAdmin)
    admin.add_view(UserExerciseProgressAdmin)
    admin.add_view(UserUnitProgressAdmin)
