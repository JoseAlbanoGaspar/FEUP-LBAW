<?php

namespace App\Http\Controllers;

use App\Models\Draft;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use DateTime;
use Illuminate\Support\Facades\Log;

use App\Models\Post;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Question;
use App\Models\Answer;
use App\Models\User;
use App\Models\Tag;
use Throwable;

class PostController extends Controller
{

    /**
     * Shows all questions asked for the user with a given id.
     * @param int $id_user
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function showQuestions($id_user)
    {
        $posts = User::find($id_user)->posts()->get();
        $questions = $posts->filter(
            function ($post) {
                return $post->question != null;
            }
        );
        return view('pages.userQuestions', ['questions' => $questions]);
    }

    /**
     * Shows all answers given for the user with a given id.
     * @param int $id_user
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function showAnswers($id_user)
    {
        $posts = User::find($id_user)->posts()->get();
        $answers = $posts->filter(
            function ($post) {
                return $post->answer != null;
            }
        );

        return view('pages.userAnswers', ['answers' => $answers]);
    }


    /**
     * Shows posts that match a given search query. The posts can be filtered by type and sorted by date or score.
     * @param Request $request
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function search(Request $request)
    {
        $query = $request->query('query');
        $filters = $request->query('filters');
        $sortReceived = $request->query('sort');
        $order = $request->query('order');
        if ($order === 'descending' || is_null($order)) {
            $order = 'desc';
        } else {
            $order = 'asc';
        }
        if ($sortReceived !== 'date' && $sortReceived !== 'score') {
            $sort = '';
        } else {
            $sort = $sortReceived;
        }

        if ($filters === null) {
            $filters = 'all';
        }

        if ($filters == 'questions') {
            if ($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?)', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('(SELECT score FROM question WHERE id_post = id_question)'. $order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            } else if ($sort === 'date') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?)', ["%$query%", "%$query%", "%$query%"])
                    ->orderBy('date', $order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?)', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
        } else if ($filters == 'answers') {
            if ($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?)', ["%$query%", "%$query%"])
                    ->orderByRaw('(SELECT score FROM answer WHERE id_answer = id_post)'.$order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);

            } else if ($sort === 'date') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?)', ["%$query%", "%$query%"])
                    ->orderBy('date', $order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('(tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?)', ["%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
        } else {
            if ($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('(id_post IN (SELECT id_question FROM question)
             or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('(SELECT score
                            FROM (SELECT id_question as id, score FROM question  UNION ALL SELECT id_answer as id, score FROM answer) as score
                            WHERE id = id_post)' . $order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);

            } else if ($sort === 'date') {
                $posts = Post::query()
                    ->whereRaw('((id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?)', ["%$query%", "%$query%", "%$query%"])
                    ->orderBy('date', $order)
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereRaw('((id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?)', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
        }

        return view('pages.search', ['posts' => $posts]);

    }

    /**
     * Shows the 30 most recent questions. Questions that use tags followed by the user appear first.
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function personalFeed()
    {
        if (Auth::check()) { //should be always true
            $user = Auth::user();
        } else {
            return redirect('login');
        }
        $posts = Post::query()->orderBy('date', 'DESC')->get();

        $questions = $posts->filter(
            function ($post) {
                return $post->question != null;
            }
        );

        $userTags = $user->followed_tags;

        // questions with tags that the user follows appear first
        $questions = $questions->sortByDesc(
            function ($question) use ($userTags) {
                $questionTags = $question->question->tags;
                $intersect = $questionTags->intersect($userTags);
                return $intersect->count();
            }
        );

        $questions = $questions->take(30);

        return view('pages.personalFeed', ['posts' => $questions]);
    }

    /**
     * Shows all questions in pages of 20 each
     * The questions can be ordered by score, date or number of answers
     * @param Request $request
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function showAllQuestions(Request $request)
    {
        $sort = $request->input('sort');
        $order = $request->input('order');
        if ($sort !== 'date' && $sort !== 'score' && $sort !== 'answercount') {
            $sort = '';
        }
        if ($order === 'descending' || is_null($order)) $order = 'desc';
        else $order = 'asc';

        if ($sort === 'score') {
            if ($order === 'asc') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->orderByRaw('(SELECT score FROM question WHERE id_question = id_post) ASC')
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->orderByRaw('(SELECT score FROM question WHERE id_question = id_post) DESC')
                    ->paginate(20);
            }
        } else if ($sort === 'date') {
            $posts = Post::query()
                ->whereRaw('id_post IN (SELECT id_question FROM question)')
                ->orderBy('date', $order)
                ->paginate(20);
        } else if ($sort === 'answercount') {
            if ($order === 'asc') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->orderByRaw('(SELECT count(*) FROM answer WHERE id_question = id_post) ASC')
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereIn('id_post', Question::query()
                        ->get(['id_question']))
                    ->orderByRaw('(SELECT count(*) FROM answer WHERE id_question = id_post) DESC')
                    ->paginate(20);
            }
        } else {
            $posts = Post::query()
                ->whereIn('id_post', Question::query()
                    ->get(['id_question']))
                ->orderBy('date', 'DESC')
                ->paginate(20);
        }


        return view('pages.allQuestions', ['posts' => $posts]);
    }

    /**
     * Show all posts in pages of 20 each, ordered by most recent
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function showAllPosts()
    {
        $posts = Post::query()->orderBy('date', 'DESC')->paginate(20);

        return view('pages.home', ['posts' => $posts]);
    }

    /**
     * Show the questions from the last two months ordered by biggest score
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function showTopQuestions()
    {
        $date = date('Y-m-d', strtotime('-1 months'));
        $posts = Post::query()->whereIn('id_post', Question::query()->get(['id_question']))
            ->orderByRaw('(SELECT score FROM question WHERE id_post = id_question) DESC')
            ->orderByRaw('(SELECT count(id_question) FROM answer WHERE id_question = id_post) DESC')
            ->where('date', '>', $date)
            ->paginate(20);

        return view('pages.home', ['posts' => $posts]);
    }


    /**
     * Show the edit page of a given questions
     * @param $id
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function updatePostForm($id)
    {
        $post = Post::find($id);
        return view('pages.editQuestion', ['post' => $post]);
    }

    public function updateAnswer(Request $request){
        $post = Post::find($request->id_post);

        $validator = Validator::make($request->all(),[
            'text_body' => 'max:511'
        ]);

        if($validator->fails()){
            return redirect()->route('question',['id_question' => $request->id_question]);
        }
        $post->text_body = $request->text_body;
        $post->date = new DateTime;

        $post->save();
        return redirect(route('question',['id_question' => $request->id_question]).'#answerid-'.$request->id_post);
    }


    public function delete(Request $request){
        $post = Post::find($request->id_post);
        if($post->answer){
            $id_question = $post->answer->id_question;
            $post->delete();
            return redirect()->route('question',['id_question' => $id_question]);
        }
        /*if($post->comment()) $post->comment->delete();
        else if ($post->answer()) {
            $post->answer->deleteComments();
            $post->answer->delete();
        } else if ($post->question()) {
            $post->question->deleteAnswers();
            $post->question->deleteComments();
            $post->question->delete();
        }*/
        $post->delete();
        return redirect()->route('allQuestions');
    }

    public function update(Request $request){

        $data = $request->all();
        $post = Post::find($data['id_post']);
        if($post->answer){
            return $this->updateAnswer($request);
        }

        $question = Question::find($post->question->id_question);

        Log::info($data);
        //Log::info($post);
        //authorize the edition!!! -> Uncomment after implemented loggin
        //$this->authorize('editProfile',$request->id_user);
        //validate results
        $validator = Validator::make($request->all(),[
            'text_body' => 'nullable|max:8192',
            'title' => 'nullable|max:256',
        ]);

        if($validator->fails()){
          return redirect()->route('updatePostForm',['id_post' => $data['id_post']])->withInput()->withErrors($validator);
        }

        //updating...
        if($data['text_body'] != NULL) $post->text_body = $data['text_body'];
        if($data['title'] != NULL) $question->title = $data['title'];
        for ($i=1; $i < 5; $i++) {
            if($data['tag'.$i] != NULL) {
                $tag = Tag::where('name',$data['tag'.$i])->first();
                if($tag == NULL) {
                    Tag::create(['name' => $data['tag'.$i]]);
                    $new_id = DB::table('tag')->latest('id_tag')->first()->id_tag;
                    $tag = Tag::find($new_id);
                } else {
                    $tag = Tag::find($tag->id_tag);
                }
                $question->tags[$i-1] = $tag;
                $tag->save();
                $question->save();
            }
        }


        //store updated information
        $post->save();
        $question->save();
        return redirect()->route('question',['id_question' => $data['id_post']]);
        //return redirect()->route('updatePostForm',['id_post' => $data['id_post']]);
    }


    //Draft Controller??
    public function showDrafts(){
        $drafts = auth()->user()->drafts()->orderBy('date','desc')->paginate(10);
        return view('pages.drafts',['drafts' => $drafts]);
    }

    public function deleteDraft(Request $request, $id_draft){
        $draft = Draft::find($id_draft);
        $draft->delete();
    }


    public function markAsSolution(Request $request){
        try {
            $answer = Answer::findOrFail($request->answerId);
        }
        catch (Throwable $e){
            return response()->json(['success' => false, 'error' => 'Answer not found'], 404);
        }
        $answer->is_solution = !($request->value == "false");
        $answer->save();
        dump($request->value);
        dump($answer->is_solution);
        $confirmation = Answer::find($request->answerId)->is_solution;
        dump($confirmation);
//        dump($answer);
        return response()->json(['success' => true]);
    }
}

