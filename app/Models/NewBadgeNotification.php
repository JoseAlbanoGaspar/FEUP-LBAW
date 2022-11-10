<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class NewBadgeNotification
 * 
 * @property int $id_notif
 * @property int|null $id_badge
 * 
 * @property Notification $notification
 * @property Badge|null $badge
 *
 * @package App\Models
 */
class NewBadgeNotification extends Model
{
	protected $table = 'new_badge_notif';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_notif' => 'int',
		'id_badge' => 'int'
	];

	protected $fillable = [
		'id_badge'
	];

	public function notification()
	{
		return $this->belongsTo(Notification::class, 'id_notif')
					->where('notification.id_notif', '=', 'new_badge_notif.id_notif')
					->where('notification.id_notif', '=', 'new_badge_notif.id_notif');
	}

	public function badge()
	{
		return $this->belongsTo(Badge::class, 'id_badge')
					->where('badge.id_badge', '=', 'new_badge_notif.id_badge')
					->where('badge.id_badge', '=', 'new_badge_notif.id_badge');
	}
}
