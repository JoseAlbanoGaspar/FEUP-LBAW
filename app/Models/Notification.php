<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Notification
 *
 * @property int $id_notif
 * @property bool $dismissed
 * @property int $id_user
 * @property Carbon $date
 *
 * @property User $user
 * @property SystemNotification $system_notification
 * @property FollowTagNotification $follow_tag_notif
 * @property MarkedAsSolutionNotification $marked_as_solution_notification
 * @property NewBadgeNotification $new_badge_notification
 * @property NewAnswerNotification $new_answer_notification
 * @property FollowedQuestionNotification $followed_question_notif
 *
 * @package App\Models
 */
class Notification extends Model
{
	protected $table = 'notification';
    protected $primaryKey = 'id_notif';
	public $timestamps = false;

	protected $casts = [
		'dismissed' => 'bool',
		'id_user' => 'int'
	];

	protected $dates = [
		'date'
	];

	protected $fillable = [
		'dismissed',
		'id_user',
		'date'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user');
	}

	public function system_notification()
	{
		return $this->hasOne(SystemNotification::class, 'id_notif');
	}

	public function follow_tag_notification()
	{
		return $this->hasOne(FollowTagNotification::class, 'id_notif');
	}

	public function marked_as_solution_notification()
	{
		return $this->hasOne(MarkedAsSolutionNotification::class, 'id_notif');
	}

	public function new_badge_notification()
	{
		return $this->hasOne(NewBadgeNotification::class, 'id_notif');
	}

	public function new_answer_notification()
	{
		return $this->hasOne(NewAnswerNotification::class, 'id_notif');
	}

	public function followed_question_notification()
	{
		return $this->hasOne(FollowedQuestionNotification::class, 'id_notif');
	}
}
