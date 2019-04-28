<#include "module/macro.ftl">
<#-- ！ 表示如果 为空，则默认值为！后面的值-->
<@head title="${options.blog_title!'Anatole'}" keywords="${options.seo_keywords!'Anatole'}" description="${options.seo_desc!'Anatole'}"></@head>
<#include "module/sidebar.ftl">
<div class="main">
    <#include "module/page-top.ftl">
    <div class="autopagerize_page_element">
        <div class="content">
            <#include "module/post_entry.ftl">
            <#--
             html 中
             >  : gt
             >= : gte
             < lt
             <= lte
            -->

            <#--
            如果 总页数  大于 1，如果等于 1 则不显示
            -->
            <#if posts.totalPages gt 1>
                <div class="pagination">
                    <ul class="clearfix">
                        <#if posts.hasPrevious()>
                            <#if posts.number == 1>
                                <li class="pre pagbuttons">
                                    <a class="btn" role="navigation" href="${options.blog_url!}/">上一页</a>
                                </li>
                            <#else >
                                <li class="pre pagbuttons">
                                    <a class="btn" role="navigation" href="${options.blog_url!}/page/${posts.number}">上一页</a>
                                </li>
                            </#if>
                        </#if>
                        <#if posts.hasNext()>
                        <li class="next pagbuttons">
                            <a class="btn" role="navigation" href="${options.blog_url!}/page/${posts.number+2}">下一页</a>
                        </li>
                        </#if>
                    </ul>
                </div>
            </#if>
        </div>
    </div>
</div>
<@footer></@footer>
