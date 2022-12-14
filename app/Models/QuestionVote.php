<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class QuestionVote
 *
 * @property int $id_user
 * @property int $id_question
 * @property int $score
 *
 * @property User $user
 * @property Question $question
 *
 * @package App\Models
 */
class QuestionVote extends Model
{
	protected $table = 'question_vote';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_user' => 'int',
		'id_question' => 'int',
		'score' => 'int'
	];

	protected $fillable = [
		'id_user', 'id_question', 'score'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user');
	}

	public function question()
	{
		return $this->belongsTo(Question::class, 'id_question');
	}
}
