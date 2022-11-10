<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class FollowsQuestion
 * 
 * @property int $id_user
 * @property int $id_question
 * 
 * @property User $user
 * @property Question $question
 *
 * @package App\Models
 */
class FollowsQuestion extends Model
{
	protected $table = 'follows_question';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_user' => 'int',
		'id_question' => 'int'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user')
					->where('user.id_user', '=', 'follows_question.id_user')
					->where('user.id_user', '=', 'follows_question.id_user');
	}

	public function question()
	{
		return $this->belongsTo(Question::class, 'id_question')
					->where('question.id_question', '=', 'follows_question.id_question')
					->where('question.id_question', '=', 'follows_question.id_question');
	}
}
