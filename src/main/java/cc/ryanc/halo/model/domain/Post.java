package cc.ryanc.halo.model.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <pre>
 *     文章／页面
 * </pre>
 *
 * @author : RYAN0UP
 * @date : 2017/11/14
 */
@Data
@Entity
@Table(name = "halo_post")
/*
操作数据库映射实体类时，通常需要记录createTime和updateTime，
如果每个对象新增或修改去都去手工操作创建时间、更新时间，会显得比较繁琐。
Spring Data JPA提供了自动填充字段的功能，简单配置一下即可。
使用时，首先声明实体类，需要在类上加上注解 @EntityListeners(AuditingEntityListener.class)
其次在 application 启动类中加上注解 @EnableJpaAuditing，同时在需要的字段上
加上 同时在需要的字段上加上@CreatedDate、@CreatedBy、@LastModifiedDate、@LastModifiedBy等注解。
这个时候，在jpa.save方法被调用的时候，时间字段会自动设置并插入数据库，
但是CreatedBy和LastModifiedBy并没有赋值，因为需要实现AuditorAware接口来返回你需要插入的值。
 */
@EntityListeners(AuditingEntityListener.class)
public class Post implements Serializable {

    private static final long serialVersionUID = -6019684584665869629L;

    /**
     * 文章编号
     */
    @Id
    @GeneratedValue
    private Long postId;

    /**
     * 发表用户 多对一
     */
    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private User user;

    /**
     * 文章标题
     */
    private String postTitle;

    /**
     * 文章类型
     * post  文章
     * page  页面
     */
    private String postType = "post";

    /**
     * 文章内容 Markdown格式
     */
    /*
    指定持久属性或字段应作为大对象持久保存到数据库支持的大对象类型
    映射到数据库 Lob 类型，便携式应用程序应使用 Lob 注释

     */
    @Lob
    private String postContentMd;

    /**
     * 文章内容 html格式
     */
    @Lob
    private String postContent;

    /**
     * 文章路径
     */
    @Column(unique = true)
    private String postUrl;

    /**
     * 文章摘要
     */
    private String postSummary;

    /**
     * 文章所属分类
     */
    /*
     多对多，建立一个中间表，记录两个之间的关系
      CascadeType.PERSIST级联刷新 ： 当 在 Post 中 运行 sava() 方法时，中间表以及 相关联的表都更新

     FetchType.LAZY：懒加载，加载一个实体时，定义懒加载的属性不会马上从数据库中加载。
        当查询 POSt 记录的时候，不去查询 halo_posts_categories 和Category，需要的时候在加载。
     FetchType.EAGER：急加载，加载一个实体时，定义急加载的属性会立即从数据库中加载。

     */
    @ManyToMany(cascade = {CascadeType.PERSIST}, fetch = FetchType.LAZY)
    @JoinTable(name = "halo_posts_categories",
            joinColumns = {@JoinColumn(name = "post_id", nullable = false)},
            inverseJoinColumns = {@JoinColumn(name = "cate_id", nullable = false)})
    private List<Category> categories = new ArrayList<>();

    /**
     * 文章所属标签
     */
    @ManyToMany(cascade = {CascadeType.PERSIST}, fetch = FetchType.LAZY)
    @JoinTable(name = "halo_posts_tags",
            joinColumns = {@JoinColumn(name = "post_id", nullable = false)},
            inverseJoinColumns = {@JoinColumn(name = "tag_id", nullable = false)})
    private List<Tag> tags = new ArrayList<>();

    /**
     * 文章的评论
     */
    @OneToMany(mappedBy = "post", cascade = {CascadeType.REMOVE}, fetch = FetchType.EAGER)
    private List<Comment> comments = new ArrayList<>();

    /**
     * 缩略图
     */
    private String postThumbnail;

    /**
     * 发表日期
     */
    @CreatedDate
    private Date postDate;

    /**
     * 最后一次更新时间
     */
    @LastModifiedDate
    private Date postUpdate;

    /**
     * 0 已发布
     * 1 草稿
     * 2 回收站
     */
    private Integer postStatus = 0;

    /**
     * 文章访问量
     */
    private Long postViews = 0L;

    /**
     * 是否允许评论
     */
    private Integer allowComment = 0;

    /**
     * 文章访问密码
     */
    private String postPassword;

    /**
     * 指定渲染模板
     */
    private String customTpl;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    public Date getPostDate() {
        return postDate;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    public Date getPostUpdate() {
        return postUpdate;
    }
}
