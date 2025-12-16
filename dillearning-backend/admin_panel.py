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
from wtforms import TextAreaField


class BaseAdmin(ModelView):
    page_size = 50
    page_size_options = [50, 100, 250, 500]
    column_searchable_list = []

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.column_list = getattr(self, "column_list", [])
        self.column_searchable_list = getattr(self, "column_searchable_list", [])


class UserAdmin(BaseAdmin, model=User):
    column_list = [User.id, User.name, User.email]
    column_searchable_list = [User.name, User.email]


class CourseAdmin(BaseAdmin, model=Course):
    column_list = [Course.id, Course.title, Course.code]
    column_details_list = [Course.id, Course.title, Course.code, Course.units]
    column_searchable_list = [Course.title, Course.code]


class UnitAdmin(BaseAdmin, model=Unit):
    column_list = [Unit.id, Unit.title, Unit.order, "course.title"]
    column_details_list = [
        Unit.id,
        Unit.title,
        Unit.order,
        "course.title",
        Unit.concepts,
    ]
    column_searchable_list = [Unit.title, "course.title"]


class ConceptAdmin(BaseAdmin, model=Concept):
    column_list = [
        Concept.title,
        "unit.title",
        "unit.id",
        "unit.course.title",
        Concept.explanation,
    ]

    column_details_list = [
        Concept.title,
        Concept.explanation,
        "unit.title",
        "unit.order",
        "unit.id",
        "unit.course.title",
        Concept.exercises,
    ]

    column_searchable_list = [Concept.title, "unit.title"]

    form_overrides = {"explanation": TextAreaField}

    form_widget_args = {
        "explanation": {
            "rows": 10,
            "placeholder": "Enter concept explanation here...",
            "class_": "form-control",
        }
    }

    def sort_query(self, stmt, request):
        from models.concept import Concept
        from models.course import Course
        from models.unit import Unit

        return (
            stmt.join(Concept.unit)
            .join(Unit.course)
            .order_by(
                Course.title.asc(),
                Unit.order.asc(),
                Concept.id.asc(),
            )
        )


class ExerciseAdmin(BaseAdmin, model=Exercise):
    column_list = [Exercise.id, Exercise.prompt, Exercise.type, "concept.title"]
    column_searchable_list = [Exercise.prompt, "concept.title"]


class LanguageAdmin(BaseAdmin, model=Language):
    column_list = [Language.id, Language.name]
    column_searchable_list = [Language.name]


class ConversationAdmin(BaseAdmin, model=Conversation):
    column_list = [Conversation.id, Conversation.user_id, Conversation.role]


class TokenBlocklistAdmin(BaseAdmin, model=TokenBlocklist):
    column_list = [TokenBlocklist.id, TokenBlocklist.jti]


class UserExerciseProgressAdmin(BaseAdmin, model=UserExerciseProgress):
    column_list = [
        UserExerciseProgress.user_id,
        UserExerciseProgress.exercise_id,
        UserExerciseProgress.completed,
    ]


class UserUnitProgressAdmin(BaseAdmin, model=UserUnitProgress):
    column_list = [
        UserUnitProgress.user_id,
        UserUnitProgress.unit_id,
        UserUnitProgress.completed,
    ]


def setup_admin(app, engine):
    admin = Admin(app, engine)

    model_views = [
        UserAdmin,
        CourseAdmin,
        UnitAdmin,
        ConceptAdmin,
        ExerciseAdmin,
        LanguageAdmin,
        ConversationAdmin,
        TokenBlocklistAdmin,
        UserExerciseProgressAdmin,
        UserUnitProgressAdmin,
    ]

    for view in model_views:
        admin.add_view(view)
