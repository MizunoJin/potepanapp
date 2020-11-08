module ApplicationHelper
  
  def full_title(page_title = "")
    base_title = "Incostagram"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def default_meta_tags
    {
      site: 'Incostagram',
      title: 'Incostagram',
      reverse: true,
      separator: '|',
      description: 'Incostagramは、インコ画像専用のSNSサービスです。インコ画像を共有し、幸せなライフを実現しましょう！',
      keywords: 'インコ',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('icon.png') },
        { href: image_url('icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'Incostagram',
        title: 'Incostagram',
        description: 'Incostagramは、インコ画像専用のSNSサービスです。インコ画像を共有し、幸せなライフを実現しましょう！', 
        type: 'website',
        url: request.original_url,
        image: image_url('1.jpg'),
        locale: 'ja_JP',
      }
    }
  end
end
