module ApplicationHelper
    def default_meta_tags
        {
          site: 'PomodoroNavi',
          title: 'PomodoroNavi',
          reverse: true,
          separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
          description: 'あなたの推しがナビになって作業時間を記録したり褒めてくれるポモドーロタイマーアプリです。',
          keywords: 'ポモドーロ,ポモドーロタイマー,ポモドーロタイマー Web,ポモドーロタイマー Webアプリ',   #キーワードを「,」区切りで設定する
          canonical: request.original_url,   #優先するURLを指定する
          noindex: ! Rails.env.production?,
          icon: [                    #favicon、apple用アイコンを指定する
            { href: image_url('favicon.ico') },
          ],
          og: {
            site_name: 'PomodoroNavi',
            title: 'PomodoroNavi',
            description: 'あなたの推しがナビになって作業時間を記録したり褒めてくれるポモドーロタイマーアプリです。',
            type: 'website',
            url: request.original_url,
            locale: 'ja_JP',
          },
          twitter: {
            card: 'summary_large_image',
          },
        }
    end
end