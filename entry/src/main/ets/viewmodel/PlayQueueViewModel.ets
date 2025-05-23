import { MusicInfo, PlaylistType } from '../model/MusicData';
import { DataSource } from './SongDataSource';
import { MediaService } from '../common/MediaService';

const TAG = 'PlayQueueModel';

@Observed
export class PlayQueueViewModel {
    songDataSource: DataSource<MusicInfo> = new DataSource<MusicInfo>();
    playlistType: string = PlaylistType.NONE;
    title: string = '播放队列';
    brief: string = '0首';
    media: MediaService = MediaService.getInstance();
    isLoading: boolean = false;

    get musicList(): MusicInfo[] {
        return this.songDataSource.items;
    }

    public refreshQueue() {
        try {
            if (this.isLoading) return;

            this.isLoading = true
            const queue = this.media.playQueue;
            const playlistType = this.media.playlistType;
            this.playlistType = playlistType;

            this.brief = queue.length + '首';

            this.songDataSource.clearData();
            this.songDataSource.setData(queue);
        } catch (e) {
            console.error(TAG, `${this.refreshQueue.name} ${e}`)
        } finally {
            this.isLoading = false;
        }
    }
}

export const localMusicModel = new PlayQueueViewModel();