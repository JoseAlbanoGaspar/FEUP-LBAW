<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Comment
 *
 * @property int $id_comment
 * @property int|null $id_question
 * @property int|null $id_answer
 *
 * @property Post $post
 * @property Question|null $question
 * @property Answer|null $answer
 *
 * @package App\Models
 */
class Comment extends Model
{
	protected $table = 'comment';
    protected $primaryKey = 'id_comment';
    public $incrementing = false;
    public $timestamps = false;

	protected $casts = [
		'id_question' => 'int',
		'id_answer' => 'int'
	];

	protected $fillable = [
		'id_question',
		'id_answer'
	];

	public function post()
	{
		return $this->belongsTo(Post::class, 'id_comment');
	}

	public function question()
	{
		return $this->belongsTo(Question::class, 'id_question');
	}

	public function answer()
	{
		return $this->belongsTo(Answer::class, 'id_answer');
	}
}
