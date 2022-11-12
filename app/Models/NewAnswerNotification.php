<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class NewAnswerNotification
 *
 * @property int $id_notif
 * @property int|null $id_answer
 *
 * @property Notification $notification
 * @property Answer|null $answer
 *
 * @package App\Models
 */
class NewAnswerNotification extends Model
{
	protected $table = 'new_answer_notif';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_notif' => 'int',
		'id_answer' => 'int'
	];

	protected $fillable = [
		'id_answer'
	];

	public function notification()
	{
		return $this->belongsTo(Notification::class, 'id_notif')
//					->where('notification.id_notif', '=', 'new_answer_notif.id_notif')
					->where('notification.id_notif', '=', 'new_answer_notif.id_notif');
	}

	public function answer()
	{
		return $this->belongsTo(Answer::class, 'id_answer')
//					->where('answer.id_answer', '=', 'new_answer_notif.id_answer')
					->where('answer.id_answer', '=', 'new_answer_notif.id_answer');
	}
}
