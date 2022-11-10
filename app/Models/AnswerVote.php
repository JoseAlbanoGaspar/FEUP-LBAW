<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class AnswerVote
 * 
 * @property int $id_user
 * @property int $id_answer
 * @property int $score
 * 
 * @property User $user
 * @property Answer $answer
 *
 * @package App\Models
 */
class AnswerVote extends Model
{
	protected $table = 'answer_vote';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_user' => 'int',
		'id_answer' => 'int',
		'score' => 'int'
	];

	protected $fillable = [
		'score'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user')
					->where('user.id_user', '=', 'answer_vote.id_user')
					->where('user.id_user', '=', 'answer_vote.id_user');
	}

	public function answer()
	{
		return $this->belongsTo(Answer::class, 'id_answer')
					->where('answer.id_answer', '=', 'answer_vote.id_answer')
					->where('answer.id_answer', '=', 'answer_vote.id_answer');
	}
}
