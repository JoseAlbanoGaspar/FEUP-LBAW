<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Question
 *
 * @property int $id_question
 * @property string $title
 * @property int|null $score
 *
 * @property Post $post
 * @property Collection|Answer[] $answers
 * @property Collection|Comment[] $comments
 * @property Collection|Tag[] $tags
 * @property Collection|FollowsQuestion[] $follows_questions
 * @property Collection|QuestionVote[] $question_votes
 *
 * @package App\Models
 */
class Question extends Model
{
	protected $table = 'question';
    protected $primaryKey = 'id_question';
    public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'score' => 'int'
	];

	protected $fillable = [
		'title',
		'score'
	];

	public function post()
	{
		return $this->belongsTo(Post::class, 'id_question');
	}

	public function answers()
	{
		return $this->hasMany(Answer::class, 'id_question');
	}

	public function comments()
	{
		return $this->hasMany(Comment::class, 'id_question');
	}

	public function tags()
	{
		return $this->belongsToMany(Tag::class, 'question_tag', 'id_question', 'id_tag');
	}

	public function follows_questions()
	{
		return $this->hasMany(FollowsQuestion::class, 'id_question');
	}

	public function question_votes()
	{
		return $this->hasMany(QuestionVote::class, 'id_question');
	}
}
