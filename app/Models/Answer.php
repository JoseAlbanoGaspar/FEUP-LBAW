<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Answer
 *
 * @property int $id_answer
 * @property int $id_question
 * @property bool $is_solution
 * @property int|null $score
 *
 * @property Post $post
 * @property Question $question
 * @property Collection|Comment[] $comments
 * @property Collection|MarkedAsSolutionNotification[] $marked_as_solution_notifications
 * @property Collection|NewAnswerNotification[] $new_answer_notifications
 * @property Collection|FollowedQuestionNotification[] $followed_question_notifs
 * @property Collection|AnswerVote[] $answer_votes
 *
 * @package App\Models
 */
class Answer extends Model
{
	protected $table = 'answer';
    protected $primaryKey = 'id_answer';
    public $incrementing = false;
    public $timestamps = false;

	protected $casts = [
		'id_question' => 'int',
		'is_solution' => 'bool',
		'score' => 'int'
	];

	protected $fillable = [
		'id_question',
		'is_solution',
		'score'
	];

	public function post()
	{
		return $this->belongsTo(Post::class, 'id_answer');
	}

	public function question()
	{
		return $this->belongsTo(Question::class, 'id_question');
	}

	public function comments()
	{
		return $this->hasMany(Comment::class, 'id_answer');
	}

	public function marked_as_solution_notifications()
	{
		return $this->hasMany(MarkedAsSolutionNotification::class, 'id_answer');
	}

	public function new_answer_notifications()
	{
		return $this->hasMany(NewAnswerNotification::class, 'id_answer');
	}

	public function followed_question_notifications()
	{
		return $this->hasMany(FollowedQuestionNotification::class, 'id_answer');
	}

	public function answer_votes()
	{
		return $this->hasMany(AnswerVote::class, 'id_answer');
	}
}
