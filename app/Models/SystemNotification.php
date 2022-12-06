<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class SystemNotification
 *
 * @property int $id_notif
 * @property string $notif_text
 *
 * @property Notification $notification
 *
 * @package App\Models
 */
class SystemNotification extends Model
{
	protected $table = 'system_notif';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_notif' => 'int'
	];

	protected $fillable = [
		'notif_text'
	];

	public function notification()
	{
		return $this->belongsTo(Notification::class, 'id_notif');
	}
}
