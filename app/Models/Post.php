<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Post
 *
 * @property int $id_post
 * @property int $id_author
 * @property Carbon $date
 * @property string $text_body
 * @property array|null $tsvectors //estava como tsvector
 *
 * @property User $user
 * @property Question $question
 * @property Answer $answer
 * @property Comment $comment
 * @property Collection|Report[] $reports
 * @property Collection|Edit[] $edits
 *
 * @package App\Models
 */
class Post extends Model
{
	protected $table = 'post';
    protected $primaryKey = 'id_post';
	public $timestamps = false;

	protected $casts = [
		'id_author' => 'int',
		'tsvectors' => 'tsvector'
	];

	protected $dates = [
		'date'
	];

	protected $fillable = [
		'id_author',
		'date',
		'text_body',
		'tsvectors'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_author')
					->where('user.id_user', '=', 'post.id_author')
					->where('user.id_user', '=', 'post.id_author');
	}

	public function question()
	{
		return $this->hasOne(Question::class, 'id_question');
	}

	public function answer()
	{
		return $this->hasOne(Answer::class, 'id_answer');
	}

	public function comment()
	{
		return $this->hasOne(Comment::class, 'id_comment');
	}

	public function reports()
	{
		return $this->hasMany(Report::class, 'id_post');
	}

	public function edits()
	{
		return $this->hasMany(Edit::class, 'id_post');
	}
}
